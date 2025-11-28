# Guide d'Architecture Godot 4.5.1

Architecture data-driven et design patterns pour projets Godot professionnels avec spec-kit.

## 🏛️ Vision d'Ensemble

### Philosophie

1. **Data-Driven** : Données séparées de la logique
2. **Composition** : Components plutôt qu'héritage
3. **Découplage** : Communication via Signaux et Services
4. **Testabilité** : Injection de dépendances, tests unitaires
5. **Maintenabilité** : Code clair, patterns établis

---

## 📁 Structure de Projet Recommandée

```
res://
├── core/                     # Infrastructure fondamentale (NE PAS MODIFIER)
│   ├── abstracts/            # Classes abstraites (@abstract)
│   │   ├── base_entity.gd
│   │   ├── base_component.gd
│   │   └── base_state.gd
│   ├── interfaces/           # Contrats via @abstract methods
│   │   ├── i_damageable.gd
│   │   └── i_interactable.gd
│   └── systems/              # Services globaux
│       ├── event_bus.gd      # Observer pattern (Autoload)
│       ├── service_locator.gd # DI (Autoload)
│       └── state_machine.gd   # State pattern générique
│
├── data/                     # TOUTES les données (100% data-driven)
│   ├── entities/             # Resources pour entités
│   │   ├── entity_data.gd    # Classe Resource
│   │   ├── player_default.tres
│   │   ├── enemy_goblin.tres
│   │   └── ...
│   ├── abilities/
│   ├── items/
│   └── config/               # Configuration globale
│       └── game_settings.tres
│
├── features/                 # Fonctionnalités par domaine
│   ├── player/
│   │   ├── player.gd
│   │   ├── player.tscn
│   │   └── components/
│   │       ├── health_component.gd
│   │       ├── movement_component.gd
│   │       └── ...
│   ├── enemies/
│   │   ├── base_enemy.gd     # Peut étendre BaseEntity
│   │   ├── goblin/
│   │   │   ├── goblin.gd
│   │   │   └── goblin.tscn
│   │   └── ...
│   └── abilities/
│
├── ui/                       # Interface utilisateur
├── tests/                    # Tests GUT
│   ├── unit/
│   ├── integration/
│   └── test_helpers/
│
└── project.godot             # Autoloads configurés
```

---

## 🏗️ Patterns Fondamentaux

### 1. Classes Abstraites (Contrats)

**Quand utiliser** : Définir un contrat que plusieurs classes doivent implémenter.

```gdscript
# core/abstracts/base_entity.gd
@abstract
class_name BaseEntity
extends Node3D

@export var entity_data: EntityData

@abstract
func initialize(data: EntityData) -> void:
	pass

@abstract
func update_logic(delta: float) -> void:
	pass
```

**Implémentation** :

```gdscript
# features/player/player.gd
class_name Player
extends BaseEntity

func initialize(data: EntityData) -> void:
	# Configuration spécifique joueur
	pass

func update_logic(delta: float) -> void:
	# Logique joueur
	pass
```

---

### 2. Resources Data-Driven

**Quand utiliser** : TOUJOURS pour les données configurables.

```gdscript
# data/entities/entity_data.gd
class_name EntityData
extends Resource

@export_group("Stats")
@export var max_health: float = 100.0
@export var move_speed: float = 5.0

@export_group("Visuals")
@export var mesh: Mesh
@export var material: Material

func _validate_property(property: Dictionary) -> void:
	if property.name == "max_health" and max_health <= 0:
		push_error("max_health invalide")
```

**Instances (.tres)** :
- `data/entities/player_default.tres`
- `data/entities/enemy_goblin.tres`

---

### 3. Component Pattern (Composition)

**Quand utiliser** : Pour fonctionnalités réutilisables (santé, mouvement, etc.).

```gdscript
# features/player/components/health_component.gd
class_name HealthComponent
extends Node

signal health_changed(current: float, max: float)
signal death()

var owner_entity: Node = null
var _current_health: float = 0.0
var _max_health: float = 100.0

func setup(entity: Node) -> void:
	owner_entity = entity
	var data = entity.entity_data
	_max_health = data.max_health
	_current_health = _max_health

func take_damage(amount: float) -> void:
	_current_health = max f(0.0, _current_health - amount)
	health_changed.emit(_current_health, _max_health)
	if _current_health <= 0:
		death.emit()
```

**Hiérarchie de scène** :

```
Player (CharacterBody3D)
├── Visuals (Node3D)
├── Collision (CollisionShape3D)
└── Components (Node)
    ├── HealthComponent
    ├── MovementComponent
    └── InteractionComponent
```

---

### 4. State Machine Pattern

**Quand utiliser** : Pour entités avec états distincts (idle, moving, attacking, etc.).

```gdscript
# features/player/states/idle_state.gd
class_name IdleState
extends Node

var state_machine: Node = null
var owner_entity: Node = null

func enter() -> void:
	# Animation idle
	owner_entity.play_animation("idle")

func exit() -> void:
	pass

func update(delta: float) -> void:
	# Vérifier transitions
	if Input.is_action_pressed("move"):
		state_machine.change_state("MovingState")
```

**StateMachine générique** :

```gdscript
# core/systems/state_machine.gd
class_name StateMachine
extends Node

signal state_changed(from: String, to: String)

@export var initial_state: String = "IdleState"
var current_state: Node = null
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		states[child.name] = child
		child.state_machine = self
		child.owner_entity = get_parent()
	
	if initial_state in states:
		change_state(initial_state)

func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()
	
	current_state = states[new_state_name]
	current_state.enter()
	state_changed.emit("", new_state_name)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
```

---

### 5. Observer Pattern (Event Bus)

**Quand utiliser** : Communication globale découplée.

```gdscript
# core/systems/event_bus.gd (Autoload)
extends Node

# Signaux globaux
signal game_started()
signal game_paused(is_paused: bool)
signal player_health_changed(current: float, max: float)
signal enemy_spawned(enemy: Node)
signal enemy_died(enemy: Node)
```

**Utilisation** :

```gdscript
# Émetteur
EventBus.player_health_changed.emit(50.0, 100.0)

# Récepteur
func _ready() -> void:
	EventBus.player_health_changed.connect(_on_player_health_changed)

func _on_player_health_changed(current: float, max: float) -> void:
	# Mettre à jour UI
	pass
```

---

### 6. Service Locator (Dependency Injection)

**Quand utiliser** : Pour services globaux accessibles partout.

```gdscript
# core/systems/service_locator.gd (Autoload)
extends Node

var _services: Dictionary = {}

func register_service(name: String, service: Object) -> void:
	_services[name] = service

func get_service(name: String) -> Object:
	return _services.get(name, null)

func has_service(name: String) -> bool:
	return name in _services
```

**Utilisation** :

```gdscript
# Enregistrement (dans un autoload d'init)
var game_manager = GameManager.new()
ServiceLocator.register_service("GameManager", game_manager)

# Accès n'importe où
var gm = ServiceLocator.get_service("GameManager")
gm.start_game()
```

---

## 🔄 Flux de Données

### Data-Driven Flow

```
Resource (.tres) → Script (charge data) → Component (utilise data)

Exemple :
player_default.tres (max_health: 100)
    ↓
player.gd (_ready: charge entity_data)
    ↓
HealthComponent.setup(entity) → lit entity_data.max_health
```

### Communication Flow

```
Component A émet signal → EventBus (si global) OU direct → Component B reçoit
                                                          ↓
                                                    Réagit via callback
```

---

## 🎯 Décisions Architecturales

### Quand utiliser Classes Abstraites ?

- ✅ Contrat strict nécessaire (ex: interface IInteractable)
- ✅ Comportement partagé par défaut (Template Method)
- ❌ Simple réutilisation de code (préférer Component)

### Quand utiliser Components ?

- ✅ Fonctionnalité réutilisable (Health, Movement, Inventory)
- ✅ Responsabilité unique et isolée
- ✅ Testabilité importante

### Quand utiliser State Machine ?

- ✅ États mutuellement exclusifs (idle/moving/attacking)
- ✅ Transitions complexes entre états
- ❌ Simple flag booléen suffit (is_alive, is_enabled)

### Quand utiliser EventBus ?

- ✅ Communication globale (UI ← → Gameplay)
- ✅ Découplage fort requis
- ❌ Communication locale (préférer signaux directs)

### Quand utiliser ServiceLocator ?

- ✅ Service global accessible partout (GameManager, SaveSystem)
- ✅ Alternative aux Autoloads multiples
- ❌ Données simples (préférer Resources)

---

## ⚡ Optimisations

### Object Pooling

```gdscript
# core/systems/object_pool.gd
class_name ObjectPool
extends Node

var _pool: Array = []
var _scene: PackedScene

func _init(scene_path: String, initial_size: int = 10):
	_scene = load(scene_path)
	_preallocate(initial_size)

func _preallocate(count: int) -> void:
	for i in count:
		var obj = _scene.instantiate()
		obj.set_meta("pooled", true)
		_pool.append(obj)

func acquire() -> Node:
	if _pool.is_empty():
		return _scene.instantiate()
	return _pool.pop_back()

func release(obj: Node) -> void:
	if obj.has_meta("pooled"):
		_pool.append(obj)
		obj.queue_free()
```

### LOD (Level of Detail)

```gdscript
# Dans entité
func _process(_delta: float) -> void:
	var distance = global_position.distance_to(camera.global_position)
	
	if distance > 50.0:
		$MeshInstance3D.layers = 0  # Invisible
	elif distance > 20.0:
		$MeshInstance3D.lod_bias = 2.0  # LOD bas
	else:
		$MeshInstance3D.lod_bias = 1.0  # LOD haut
```

---

## 📋 Checklist Architecture

- [ ] Structure projet suit le template recommandé
- [ ] Toutes données dans `data/` (Resources)
- [ ] Components pour fonctionnalités réutilisables
- [ ] State Machine si états multiples
- [ ] EventBus pour communication globale
- [ ] ServiceLocator pour services globaux
- [ ] Tests GUT pour Components critiques
- [ ] Pas d'Autoloads excessifs (max 5)
- [ ] Pas de "God classes"
- [ ] Documentation des patterns utilisés dans plan.md
