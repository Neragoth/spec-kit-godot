# Standards de Code Godot 4.5.1

Guide des conventions et standards stricts pour le développement avec Godot 4.5.1 dans le contexte de spec-kit.

## 📜 Principes Fondamentaux

### 1. Data-Driven First
- ✅ **TOUTES** les données configurables dans des Resources (.tres)
- ❌ **AUCUNE** valeur hard-codée dans les scripts
- ✅ Logique **minimale** dans les scripts, délégation aux Components

### 2. Composition Over Inheritance
- ✅ Utiliser des **Components** pour la réutilisabilité
- ❌ Éviter les hiérarchies d'héritage profondes (>2 niveaux)
- ✅ Classes abstraites (`@abstract`) uniquement pour définir des contrats

### 3. Single Responsibility
- ✅ Chaque classe/Component = **une seule responsabilité**
- ✅ Fichiers courts (< 300 lignes idéalement)
- ❌ "God classes" interdites

---

## 🏷️ Conventions de Nommage

### Classes et Types

```gdscript
# Classes (PascalCase)
class_name PlayerEntity
class_name HealthComponent
class_name EnemyData

# Fichiers correspondants
player_entity.gd
health_component.gd
enemy_data.gd
```

### Variables

```gdscript
# Variables publiques (snake_case)
var player_health: float = 100.0
var move_speed: Vector3 = Vector3.ZERO
var is_active: bool = true

# Variables privées (préfixe _ + snake_case)
var _internal_state: int = 0
var _cached_position: Vector3 = Vector3.ZERO
var _update_timer: float = 0.0
```

### Constantes et Enums

```gdscript
# Constantes (SCREAMING_SNAKE_CASE)
const MAX_HEALTH: float = 100.0
const DEFAULT_SPEED: float = 5.0
const GRAVITY: float = 9.8

# Enums
enum State {
	IDLE,          # UPPERCASE pour valeurs
	MOVING,
	ATTACKING,
	DEAD
}

enum DamageType {
	PHYSICAL,
	MAGICAL,
	TRUE_DAMAGE
}
```

### Fonctions

```gdscript
# Fonctions publiques (snake_case)
func calculate_damage(base: float, modifier: float) -> float:
	return base * modifier

func apply_force(force: Vector3) -> void:
	pass

# Fonctions privées (préfixe _ + snake_case)
func _update_internal_state() -> void:
	pass

func _calculate_path(start: Vector3, end: Vector3) -> PackedVector3Array:
	return PackedVector3Array()
```

### Signaux

```gdscript
# Signaux (snake_case)
signal health_changed(current: float, max: float)
signal state_changed(old_state: State, new_state: State)
signal player_died
signal enemy_spawned(enemy: Node)
```

---

## 📂 Organisation du Code avec #region (Godot 4.5.1)

**Ordre STRICT des régions** :

```gdscript
class_name ExempleComplet
extends Node3D

## DocString de classe OBLIGATOIRE en français.
## Décrit le rôle et la responsabilité.

#region Constantes
const MAX_SPEED: float = 10.0
const MIN_SPEED: float = 1.0
#endregion

#region Énumérations
enum State {
	IDLE,
	MOVING,
	ATTACKING
}
#endregion

#region Signaux
signal state_changed(old_state: State, new_state: State)
signal health_depleted
#endregion

#region Propriétés Exportées
@export_group("Configuration")
@export var speed: float = 5.0

@export_group("Références")
@export var target: Node3D
#endregion

#region Propriétés Publiques
var current_state: State = State.IDLE
var is_alive: bool = true
#endregion

#region Propriétés Privées
var _velocity: Vector3 = Vector3.ZERO
var _internal_timer: float = 0.0
#endregion

#region Lifecycle Godot
func _ready() -> void:
	_initialize()

func _process(delta: float) -> void:
	_update_logic(delta)

func _physics_process(delta: float) -> void:
	_update_physics(delta)

func _exit_tree() -> void:
	_cleanup()
#endregion

#region API Publique
## Méthode publique avec DocString.
## @param value: Description du paramètre
## @return: Description du retour
func public_method(value: float) -> void:
	pass
#endregion

#region Méthodes Privées
func _initialize() -> void:
	pass

func _update_logic(delta: float) -> void:
	pass

func _update_physics(delta: float) -> void:
	pass

func _cleanup() -> void:
	pass
#endregion

#region Callbacks Signaux (optionnel)
func _on_health_changed(current: float, max: float) -> void:
	pass
#endregion
```

---

## 💬 Commentaires et Documentation

### DocStrings (Obligatoires)

```gdscript
## Documentation de classe.
## Décrit le rôle, responsabilités, et utilisation globale.
## TOUJOURS en français.
class_name MaClasse
extends Node

## Applique des dégâts à l'entité.
## Prend en compte la défense et les résistances.
## @param amount: Quantité de dégâts bruts
## @param damage_type: Type de dégâts (PHYSICAL, MAGICAL, etc.)
## @param source: Source des dégâts (peut être null)
## @return: Dégâts réellement infligés après réductions
func take_damage(amount: float, damage_type: DamageType, source: Node = null) -> float:
	return 0.0
```

### Commentaires Inline

```gdscript
# Commentaires d'implémentation (# simple)
# Expliquer le POURQUOI, pas le QUOI (le code explique le QUOI)

func calculate_complex_value(input: float) -> float:
	# Normalisation pour éviter les valeurs extrêmes
	# qui causent des artifacts visuels
	var normalized = clampf(input, 0.0, 1.0)
	
	# Application de la courbe exponentielle pour
	# un meilleur feeling de gameplay
	return pow(normalized, 2.0)
```

### Tags Spéciaux

```gdscript
# TODO: Implémenter système de pooling pour optimisation
# FIXME: bug avec collisions multiples simultanées
# HACK: Solution temporaire, à refactorer après v1.0
# NOTE: Cette valeur est précalculée pour performance
# OPTIMIZE: Boucle appelée 60x/sec, potentiel d'optimisation
```

---

## 🎯 Classes Abstraites (@abstract - Godot 4.5.1)

```gdscript
## Classe abstraite de base pour toutes les entités.
## NE PEUT PAS être instanciée directement.
@abstract
class_name BaseEntity
extends Node3D

## Initialise l'entité avec ses données.
## DOIT être implémenté par les classes dérivées.
@abstract
func initialize(data: EntityData) -> void:
	pass

## Met à jour la logique de l'entité.
## DOIT être implémenté.
@abstract
func update_logic(delta: float) -> void:
	pass

## Méthode virtuelle (peut être overridée, pas obligatoire).
func on_spawned() -> void:
	pass
```

**Utilisation** :

```gdscript
class_name Player
extends BaseEntity

## Implémentation obligatoire
func initialize(data: EntityData) -> void:
	# Implémentation spécifique au joueur
	pass

## Implémentation obligatoire
func update_logic(delta: float) -> void:
	# Logique du joueur
	pass

## Override optionnel
func on_spawned() -> void:
	super.on_spawned()  # Appeler parent si nécessaire
	# Logique supplémentaire
```

---

## 📦 Resources Data-Driven

### Définition

```gdscript
class_name PlayerData
extends Resource

## Resource de données pour le joueur.
## 100% déclaratif, AUCUNE logique métier.

#region Stats
@export_group("Stats de Base")
@export_range(1, 1000, 1) var max_health: float = 100.0
@export_range(0.1, 50.0, 0.1) var move_speed: float = 5.0
#endregion

#region Validation
## TOUJOURS valider les données critiques
func _validate_property(property: Dictionary) -> void:
	if property.name == "max_health" and max_health <= 0:
		push_error("max_health doit être > 0")
#endregion
```

### Utilisation

```gdscript
class_name Player
extends CharacterBody3D

@export var player_data: PlayerData

func _ready() -> void:
	if player_data:
		# Charger les stats depuis le Resource
		max_health = player_data.max_health
		move_speed = player_data.move_speed
	else:
		push_error("player_data non assigné !")
```

---

## 🧩 Components (Composition)

```gdscript
class_name HealthComponent
extends Node

## Component gérant la santé d'une entité.
## Responsabilité UNIQUE : Gérer HP, dégâts, mort.

#region Signaux
signal health_changed(current: float, max: float)
signal damage_taken(amount: float, source: Node)
signal death()
#endregion

#region Propriétés
var owner_entity: Node = null
var _current_health: float = 0.0
var _max_health: float = 100.0
#endregion

#region Setup
## DOIT être appelé par l'entité parente
func setup(entity: Node) -> void:
	owner_entity = entity
	
	# Charger config depuis EntityData
	if entity.has_method("get_entity_data"):
		var data = entity.get_entity_data()
		_max_health = data.max_health
		_current_health = _max_health
#endregion

#region API Publique
func take_damage(amount: float, source: Node = null) -> void:
	_current_health = maxf(0.0, _current_health - amount)
	damage_taken.emit(amount, source)
	health_changed.emit(_current_health, _max_health)
	
	if _current_health <= 0:
		death.emit()
#endregion
```

---

## ⚠️ Anti-Patterns à ÉVITER

### ❌ Hard-Coding

```gdscript
# ❌ MAUVAIS
func _ready() -> void:
	max_health = 100.0  # Valeur hard-codée !
	move_speed = 5.0

# ✅ BON
@export var entity_data: EntityData

func _ready() -> void:
	max_health = entity_data.max_health
	move_speed = entity_data.move_speed
```

### ❌ God Classes

```gdscript
# ❌ MAUVAIS - Classe qui fait TOUT
class_name Player extends CharacterBody3D:
	var health: float
	var stamina: float
	var inventory: Array
	var quest_log: Array
	
	func take_damage(): pass
	func attack(): pass
	func pickup_item(): pass
	func complete_quest(): pass
	func save_game(): pass
	...  # 50+ méthodes
```

```gdscript
# ✅ BON - Responsabilités séparées en Components
class_name Player extends CharacterBody3D:
	@onready var health_comp = $Components/HealthComponent
	@onready var inventory_comp = $Components/InventoryComponent
	@onready var quest_comp = $Components/QuestComponent
```

### ❌ Deep Inheritance

```gdscript
# ❌ MAUVAIS
Entity -> LivingEntity -> Humanoid -> Character -> Player

# ✅ BON
BaseEntity -> Player (avec Components pour fonctionnalités)
```

### ❌ Print() pour Debug

```gdscript
# ❌ MAUVAIS
print("Health:", health)

# ✅ BON
push_warning("Health critique: %s" % health)
# ou
if debug_mode:
	print_debug("[Player] Health: %s" % health)
```

---

## ✅ Checklist Avant Commit

- [ ] Code organisé avec `#region`
- [ ] Classes abstraites (`@abstract`) si applicable
- [ ] Aucune valeur hard-codée
- [ ] Commentaires en **FRANÇAIS uniquement**
- [ ] DocStrings pour méthodes publiques
- [ ] Nommage conforme (snake_case, PascalCase, etc.)
- [ ] Signaux typés
- [ ] Pas de `print()` (sauf debug conditionnel)
- [ ] Resources validés (`_validate_property()`)
- [ ] Tests GUT si Component
