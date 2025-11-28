# Plan d'Implémentation - [Nom de la Fonctionnalité]

**Architecture** : Data-Driven | **Patterns** : [Liste] | **Godot** : 4.5.1  
**Branche** : `[###-feature-name]` | **Date** : [DATE] | **Spec** : [lien]

Ce plan décrit l'implémentation technique de [Nom de la Fonctionnalité] en utilisant les meilleures pratiques Godot 4.5 (Architecture Propre, Conception Pilotée par les Données, Design Patterns de l'industrie).

## ⚠️ Revue Utilisateur Requise

> [!IMPORTANT]
> Décisions techniques critiques ou changements cassants.
> - Breaking changes potentiels
> - Nouvelles dépendances externes
> - Impact sur les performances

## 🏗️ Architecture Proposée

### 1. Classes Abstraites (@abstract) - _si applicable_

<!--
  Définir les classes abstraites qui servent de contrats/templates.
  Utiliser @abstract (Godot 4.5.1) pour forcer l'implémentation.
-->

#### Base[Nom].gd (extends [ParentClass])

**Localisation** : `core/abstracts/base_[nom].gd`

**Méthodes Abstraites** :
- `@abstract func initialize() -> void` : [Description]
- `@abstract func update_logic(delta: float) -> void` : [Description]

**Méthodes Virtuelles** (peuvent être overridées) :
- `func on_ready() -> void` : [Description]

**Raison d'être** : [Expliquer pourquoi cette abstraction est nécessaire]

**Pattern** : Template Method / Strategy

---

### 2. Resources Data-Driven

<!--
  CRITIQUE : Toutes les données configurables DOIVENT être dans des Resources.
  Aucune valeur hard-codée dans les scripts. 100% data-driven.
-->

#### [Nom]Data.gd (extends Resource)

**Localisation** : `data/[category]/[nom]_data.gd`

**Propriétés Exportées** :
```gdscript
@export_group("Stats de Base")
@export var max_health: float = 100.0
@export var move_speed: float = 5.0

@export_group("Comportement")
@export var ai_behavior: AIBehaviorData  # Resource imbriquée
```

**Validation** : Implémenter `_validate_property()` pour la validation des données

**Fichiers .tres à créer** :
- `data/[category]/[nom]_default.tres` : Configuration par défaut
- `data/[category]/[nom]_variant_1.tres` : Variante 1
- `data/[category]/[nom]_variant_2.tres` : Variante 2

---

### 3. Components (Composition)

<!--
  Utiliser la composition plutôt que l'héritage profond.
  Chaque Component est une responsabilité unique et réutilisable.
-->

**Structure** :
```
features/[feature]/components/
├── health_component.gd          # Gère la santé
├── movement_component.gd        # Gère le déplacement
└── interaction_component.gd     # Gère les interactions
```

**Chaque Component** :
- Étend `BaseComponent` (classe abstraite)
- Reçoit les données via Resource
- Communique via Signaux
- **Responsabilité unique** (Single Responsibility Principle)

**Dépendances** :
- `core/abstracts/base_component.gd` : Classe abstraite de base

---

### 4. State Machine - _si applicable_

<!--
  Si la fonctionnalité nécessite des états (idle, moving, attacking, etc.),
  utiliser une State Machine générique.
-->

**États Définis** :
- `IdleState` : [Description du comportement]
- `MovingState` : [Description du comportement]
- `AttackingState` : [Description du comportement]

**Transitions** :
```
Idle -> Moving : Quand [condition]
Moving -> Attacking : Quand [condition]
Attacking -> Idle : Quand [condition terminée]
```

**Localisation** :
```
features/[feature]/states/
├── idle_state.gd
├── moving_state.gd
└── attacking_state.gd
```

**Dépendances** :
- `core/abstracts/base_state.gd` : Classe abstraite pour états
- `core/systems/state_machine.gd` : State Machine générique

---

### 5. Structure de Scène

<!--
  Définir la hiérarchie des Nœuds pour les nouvelles scènes.
  Séparer visuels, logique, et collision.
-->

#### [NomScene].tscn

**Hiérarchie** :
```
RootNode ([Type] - ex: CharacterBody3D)
├── Visuals (Node3D/Node2D)
│   ├── MeshInstance3D / Sprite2D
│   └── AnimationPlayer
├── Collision (CollisionShape3D/2D)
├── Components (Node)
│   ├── HealthComponent (Node)
│   ├── MovementComponent (Node)
│   └── [Autre]Component (Node)
└── StateMachine (Node)
    ├── IdleState
    ├── MovingState
    └── AttackingState
```

**Script Attaché** : `features/[feature]/[nom].gd`

**Data Resource** : Référence vers `[Nom]Data.tres`

---

### 6. Signaux & Communication

<!--
  Définir comment les différentes parties communiquent.
  Privilégier les Signaux pour le découplage.
-->

#### Signaux Globaux (EventBus)

**Localisation** : `core/systems/event_bus.gd` (Autoload)

Nouveaux signaux à ajouter :
- `signal [feature]_started()` : Émis quand [condition]
- `signal [feature]_completed(result: Variant)` : Émis quand [condition]
- `signal [feature]_failed(reason: String)` : Émis quand [condition]

#### Signaux Locaux (Components/Entités)

**Dans [Nom]Component** :
- `signal value_changed(new_value: Variant)` : [Description]
- `signal action_triggered()` : [Description]

**Connexions** :
- `[Source].[signal_name]` -> `[Target].on_[signal_name]()`

---

### 7. Services & Systèmes - _si applicable_

<!--
  Si la fonctionnalité nécessite un système global ou service.
-->

#### [Nom]Service.gd

**Localisation** : `core/systems/[nom]_service.gd`

**Type** : Singleton (Autoload) / Service Locator

**Responsabilités** :
- [Responsabilité 1]
- [Responsabilité 2]

**API Publique** :
```gdscript
func register_[entity]() -> void
func get_[entity]() -> [Type]
func process_[action]() -> void
```

**Dépendances** :
- ServiceLocator (si utilisé)
- EventBus

---

## 📁 Changements Proposés

### Core Systems

#### [NEW] core/abstracts/base_[nom].gd
- **Rôle** : Classe abstraite de base pour [type d'entité]
- **Méthodes abstraites** : `initialize()`, `update_logic()`
- **Pattern** : Template Method
- **Utilise** : `@abstract` (Godot 4.5.1)
- **Organisation** : Code structuré avec `#region`

#### [NEW] core/systems/[nom]_service.gd
- **Rôle** : Service global pour gérer [fonctionnalité]
- **Singleton** : Oui (Autoload : [NomService])
- **Pattern** : Singleton, Service Locator
- **Dépendances** : EventBus, ServiceLocator

---

### Data Layer (100% Data-Driven)

#### [NEW] data/[category]/[nom]_data.gd
- **Type** : Resource
- **Propriétés** : [Lister toutes les @export avec types]
- **Validation** : `_validate_property()` implémenté
- **Imbrication** : [Lister les Resources imbriquées]

#### [NEW] data/[category]/*.tres
- **Fichiers** : [Lister chaque .tres à créer]
- **Variantes** : [Décrire les différentes configurations]

---

### Features (Logique Minimale)

#### [NEW] features/[feature]/[nom].gd
- **Type** : [CharacterBody3D / Node / etc.]
- **Data Source** : Charge `[Nom]Data.tres`
- **Composition** : Utilise Components (Health, Movement, etc.)
- **State** : Utilise StateMachine si applicable
- **Organisation** : Code structuré avec `#region` (Godot 4.5.1)
- **Commentaires** : FRANÇAIS, DocStrings obligatoires

#### [NEW] features/[feature]/[nom].tscn
- **Hiérarchie** : [Référence à la structure de scène ci-dessus]
- **Script** : Attaché à RootNode
- **Exported Vars** : `@export var entity_data: [Nom]Data`

#### [NEW] features/[feature]/components/[nom]_component.gd
- **Extends** : `BaseComponent`
- **Responsabilité** : [Unique responsabilité]
- **Signaux** : [Lister les signaux]
- **Data** : Reçoit configuration via parent
- **Pattern** : Component Pattern
- **Organisation** : `#region` pour Signaux, Propriétés, API, Privé

#### [NEW] features/[feature]/states/[nom]_state.gd - _si applicable_
- **Extends** : `BaseState`
- **Responsabilité** : Gérer l'état [nom]
- **Méthodes** : `enter()`, `exit()`, `update()`, `physics_update()`
- **Transitions** : Vers [autres états]

---

## 🧪 Plan de Vérification

### Tests Automatisés (GUT)

**Structure** :
```
tests/
├── unit/
│   └── test_[nom]_component.gd
├── integration/
│   └── test_[feature]_integration.gd
└── test_helpers/
    └── [nom]_test_helper.gd
```

**Tests Unitaires** :
```gdscript
# tests/unit/test_[nom]_component.gd
extends GutTest

func test_component_initialization():
	var component = [Nom]Component.new()
	assert_not_null(component)

func test_[specific_behavior]():
	# Test du comportement spécifique
	pass
```

**Tests d'Intégration** :
- Scène de test : `tests/integration/[feature]_test.tscn`
- Vérifier : [Lister les comportements à tester]

### Vérification Manuelle

**Scène** : `[Chemin vers la Scène]`

**Actions** :
1. Lancer la scène
2. [Action spécifique 1]
3. [Action spécifique 2]

**Résultats Attendus** :
- [Confirmation Visuelle/Audio 1]
- [Confirmation Visuelle/Audio 2]

**Métriques de Performance** :
- FPS cible : 60 FPS
- Temps de chargement : < [X]ms
- Utilisation mémoire : < [X]MB

---

## 📊 Métriques de Qualité

**Couplage** : ⬇️ Faible
- Utilisation de Signaux pour communication
- Service Locator pour dépendances
- Pas de références directes entre systèmes

**Cohésion** : ⬆️ Forte
- Chaque classe a une responsabilité unique
- Components focalisés sur une tâche
- Resources purement déclaratives

**Testabilité** : ⬆️ Élevée
- Injection de dépendances via Resources
- Components isolés et testables
- Mocking facile via interfaces (@abstract)

**Maintenabilité** : ⬆️ Élevée
- Code organisé avec `#region`
- Documentation en français
- Architecture data-driven (changements dans .tres, pas dans code)

---

## 📋 Checklist de Conformité

Chaque fichier créé DOIT respecter :

- [ ] Code organisé avec **#region** (Godot 4.5.1)
- [ ] Classes abstraites utilisent **@abstract** si applicable
- [ ] Données dans **Resources** (.tres), pas hard-codées
- [ ] Commentaires et DocStrings en **FRANÇAIS**
- [ ] Nommage conforme : `snake_case`, `PascalCase`, `SCREAMING_SNAKE_CASE`
- [ ] Signaux documentés avec types
- [ ] Aucune logique métier dans scènes (.tscn)
- [ ] Tests GUT créés pour chaque Component
- [ ] Validation `_validate_property()` pour Resources
- [ ] Pas de Singleton sauf justification (préférer ServiceLocator)
- [ ] Components indépendants et réutilisables
- [ ] Pas de `print()` (utiliser `push_warning()` / `push_error()`)

---

## 🔄 Dépendances

**Prérequis Core** (à créer si non existants) :
- `core/abstracts/base_component.gd`
- `core/abstracts/base_state.gd`
- `core/systems/state_machine.gd`
- `core/systems/event_bus.gd` (Autoload)
- `core/systems/service_locator.gd` (Autoload)

**Ordre de Création** :
1. Core abstracts et systems
2. Resources (.gd puis .tres)
3. Components
4. States (si applicable)
5. Feature principale
6. Tests

---

## 📚 Références & Patterns Utilisés

**Design Patterns** :
- Template Method : Classes abstraites avec comportement par défaut
- Component : Composition pour réutilisabilité
- State Machine : Gestion des états
- Observer : Signaux et EventBus
- Service Locator : Injection de dépendances
- [Autres patterns spécifiques]

**Documentation Godot** :
- [Abstract Classes](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html)
- [Resources](https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html)
- [Signals](https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html)
