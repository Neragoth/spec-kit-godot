# Liste de Tâches - [Nom de la Fonctionnalité]

**Entrée** : Design documents depuis `/specs/[###-feature-name]/`  
**Prérequis** : `plan.md` (requis), `spec.md` (requis)

<!--
  PHILOSOPHIE :
  Décomposer l'implémentation en petites étapes vérifiables.
  Suivre l'ordre strict : Core -> Data -> Visuals -> Logic -> Tests
  
  QUALITÉ :
  Chaque tâche DOIT respecter les standards :
  - Code organisé avec #region (Godot 4.5.1)
  - Commentaires en FRANÇAIS
  - Data-driven (Resources, pas de hard-coding)
  - Patterns définis dans plan.md
-->

---

## 🏗️ Phase 0 : Core Infrastructure _(si nouveau)_

**Objectif** : Créer les classes abstraites et systèmes de base si cette fonctionnalité en nécessite

- [ ] **T000** : Créer `core/abstracts/base_[nom].gd` avec `@abstract` <!-- id: 0 -->
  - Définir méthodes abstraites selon plan.md
  - Structurer avec `#region` : Signaux, Propriétés, Abstraites, Virtuelles
  - DocStrings en français pour chaque méthode
  
- [ ] **T001** : Créer `core/systems/[nom]_service.gd` si service global nécessaire <!-- id: 1 -->
  - Pattern : Singleton / Service Locator
  - Enregistrer dans ServiceLocator
  - Configurer Autoload si applicable

---

## 📦 Phase 1 : Data Layer (100% Data-Driven)

**Objectif** : Définir TOUTES les données dans des Resources AVANT toute logique

### Resources (Classes)

- [ ] **T010** : Créer `data/[category]/[nom]_data.gd` extends Resource <!-- id: 10 -->
  - `#region Propriétés Exportées` avec `@export` et types stricts
  - `#region Validation` avec `_validate_property()` pour chaque propriété critique
  - Commentaires français pour chaque `@export`
  - Groupes logiques avec `@export_group()`

- [ ] **T011** : Créer Resources imbriquées si nécessaire <!-- id: 11 -->
  - Ex: `AIBehaviorData.gd`, `LootTableData.gd`, etc.
  - Suivre même structure que T010

### Instances (.tres)

- [ ] **T012** : Créer `[nom]_default.tres` configuration par défaut <!-- id: 12 -->
  - Remplir toutes les propriétés avec valeurs sensées
  - Tester le chargement avec `load()`

- [ ] **T013** : Créer variantes `.tres` pour chaque configuration <!-- id: 13 -->
  - `[nom]_variant_1.tres`
  - `[nom]_variant_2.tres`
  - Documenter les différences dans `data/[category]/README.md`

---

## 🎨 Phase 2 : Visuels & Scènes

**Objectif** : Créer les scènes avec hiérarchie correcte, SANS logique encore

### Scènes Principales

- [ ] **T020** : Créer `features/[feature]/[nom].tscn` <!-- id: 20 -->
  - RootNode avec type correct (CharacterBody3D, Area3D, etc.)
  - Sous-nodes : Visuals, Collision, Components (vides), StateMachine (vide)
  - Référence Resource : `@export var entity_data: [Nom]Data`
  - Pas de script encore (T030)

### Assets Visuels

- [ ] **T021** : Ajouter MeshInstance3D / Sprite2D dans Visuals <!-- id: 21 -->
  - Importer assets depuis spec.md
  - Configurer materials/textures
  - Tester rendu visuel

- [ ] **T022** : Ajouter AnimationPlayer et animations <!-- id: 22 -->
  - Créer animations selon spec.md
  - Configurer AnimationTree si nécessaire

- [ ] **T023** : Ajouter collision shapes <!-- id: 23 -->
  - CollisionShape3D/2D adaptée à la forme
  - Layers et masks selon architecture
  - Pas de logique de collision encore

---

## 🧩 Phase 3 : Components (Composition)

**Objectif** : Créer les Components réutilisables avec logique isolée

### Base Components

- [ ] **T030** : Créer `features/[feature]/components/[nom]_component.gd` <!-- id: 30 -->
  - `extends BaseComponent`
  - `#region Signaux` : Déclarer tous les signaux avec types
  - `#region Propriétés Privées` : `var _internal: Type`
  - `#region Setup` : `func setup(entity: Node) -> void`
  - `#region API Publique` : Méthodes publiques avec DocStrings français
  - `#region Méthodes Privées` : `func _internal_method() -> void`

- [ ] **T031** : Répéter T030 pour chaque Component listé dans plan.md <!-- id: 31 -->
  - HealthComponent
  - MovementComponent
  - InteractionComponent
  - [Autres]

### Intégration Components dans Scène

- [ ] **T032** : Attacher les Components nodes dans `[nom].tscn` <!-- id: 32 -->
  - Ajouter chaque Component comme enfant de Components node
  - Vérifier hiérarchie : RootNode/Components/[Nom]Component

---

## 🔄 Phase 4 : States (State Machine) _(si applicable)_

**Objectif** : Implémenter les états si la fonctionnalité en nécessite

### Création des States

- [ ] **T040** : Créer `features/[feature]/states/[nom]_state.gd` <!-- id: 40 -->
  - `extends BaseState`
  - `#region Lifecycle` avec méthodes obligatoires :
    - `func enter() -> void`
    - `func exit() -> void`
    - `func update(delta: float) -> void`
    - `func physics_update(delta: float) -> void`
  - Logique spécifique à l'état en français

- [ ] **T041** : Répéter T040 pour chaque état <!-- id: 41 -->
  - IdleState
  - MovingState
  - [Autres états selon spec.md]

### Intégration State Machine

- [ ] **T042** : Attacher StateMachine dans `[nom].tscn` <!-- id: 42 -->
  - Ajouter `StateMachine` node (instance de `core/systems/state_machine.gd`)
  - Ajouter chaque State comme enfant
  - Configurer `initial_state`

---

## 🧠 Phase 5 : Logique Principale

**Objectif** : Implémenter le script principal qui orchestre Components et States

### Script Principal

- [ ] **T050** : Créer `features/[feature]/[nom].gd` <!-- id: 50 -->
  - Attacher à RootNode dans `[nom].tscn`
  - Structure complète avec `#region` :
    ```gdscript
    #region Constantes
    #region Énumérations
    #region Signaux
    #region Propriétés Exportées
    #region Propriétés Publiques
    #region Propriétés Privées
    #region Lifecycle Godot (_ready, _process, _physics_process)
    #region API Publique
    #region Méthodes Privées
    #region Callbacks Signaux
    ```

- [ ] **T051** : Implémenter `_ready()` <!-- id: 51 -->
  - Charger `entity_data` Resource
  - Initialiser Components avec `setup()`
  - Connecter signaux

- [ ] **T052** : Implémenter logique métier selon spec.md <!-- id: 52 -->
  - Logique MINIMALE (déléguer aux Components)
  - Orchestration Components via leurs APIs
  - Communication via Signaux

### Signaux & Communication

- [ ] **T053** : Connecter signaux Components -> Script Principal <!-- id: 53 -->
  - `component.signal_name.connect(_on_component_signal)`
  - Callbacks en `#region Callbacks Signaux`

- [ ] **T054** : Connecter signaux globaux EventBus si applicable <!-- id: 54 -->
  - `EventBus.event_name.connect(_on_global_event)`

---

## 🧪 Phase 6 : Tests & Vérification

**Objectif** : Tester chaque Component et l'intégration complète

### Tests Unitaires (GUT)

- [ ] **T060** : Créer `tests/unit/test_[nom]_component.gd` <!-- id: 60 -->
  - `extends GutTest`
  - Test pour chaque méthode publique du Component
  - Mock des dépendances si nécessaire
  - Assertions claires en français

- [ ] **T061** : Répéter T060 pour chaque Component <!-- id: 61 -->

### Tests d'Intégration

- [ ] **T062** : Créer scène de test `tests/integration/[feature]_test.tscn` <!-- id: 62 -->
  - Instancier la fonctionnalité complète
  - Script de test automatisé si possible

- [ ] **T063** : Créer `tests/integration/test_[feature]_integration.gd` <!-- id: 63 -->
  - Tester scénarios de spec.md
  - Vérifier critères d'acceptation

### Vérification Manuelle

- [ ] **T064** : Tester chaque scénario de spec.md manuellement <!-- id: 64 -->
  - Lancer scène de test
  - Suivre instructions "Test Indépendant"
  - Valider feedback visuel/audio
  - Vérifier critères de succès (FPS, timing, etc.)

- [ ] **T065** : Profiling et optimisation <!-- id: 65 -->
  - Godot Profiler : Vérifier FPS, memory, draw calls
  - Optimiser si nécessaire (Object Pooling, LOD, etc.)

---

## ✨ Phase 7 : Polish & Finalisation

**Objectif** : Peaufiner, documenter, et valider qualité

### Code Quality

- [ ] **T070** : Code review selon checklist plan.md <!-- id: 70 -->
  - Vérifier `#region` partout
  - Vérifier commentaires français
  - Vérifier data-driven (aucun hard-coding)
  - Vérifier nommage (snake_case, PascalCase, etc.)

- [ ] **T071** : Documenter dans `features/[feature]/README.md` <!-- id: 71 -->
  - Usage des Components
  - Configuration des Resources
  - Exemple d'utilisation

### Intégration Projet

- [ ] **T072** : Ajouter à EventBus si événements globaux <!-- id: 72 -->
  - Documenter nouveaux signaux dans `core/systems/event_bus.gd`

- [ ] **T073** : Enregistrer service dans ServiceLocator si applicable <!-- id: 73 -->
  - `ServiceLocator.register_service("[nom]", instance)`

- [ ] **T074** : Mettre à jour `project.godot` avec Autoloads si nécessaire <!-- id: 74 -->

---

## 📋 Checklist Finale (Avant Merge)

Valider que chaque fichier créé respecte :

- [ ] ✅ Code organisé avec **#region** (Godot 4.5.1)
- [ ] ✅ Classes abstraites utilisent **@abstract** si applicable
- [ ] ✅ Toutes données dans **Resources** (.tres), aucun hard-coding
- [ ] ✅ Commentaires et DocStrings en **FRANÇAIS uniquement**
- [ ] ✅ Nommage conforme : `snake_case`, `PascalCase`, `SCREAMING_SNAKE_CASE`
- [ ] ✅ Signaux typés et documentés
- [ ] ✅ Tests GUT > 80% coverage pour Components
- [ ] ✅ Validation `_validate_property()` pour Resources
- [ ] ✅ Aucun `print()` (remplacé par `push_warning/error`)
- [ ] ✅ Aucun Singleton sauf justification
- [ ] ✅ Components indépendants et réutilisables
- [ ] ✅ Performance : FPS >= 60, Memory < seuil spec.md

---

## 🔗 Dépendances & Ordre d'Exécution

```
Phase 0 (Core) → BLOQUE → Phases 1-7
└─ Classes abstraites doivent exister avant usage

Phase 1 (Data) → BLOQUE → Phases 2-7
└─ Resources doivent exister avant chargement

Phase 2 (Visuels) ─┐
                    ├→ Phase 5 (Logique)
Phase 3 (Components)─┤
                    ├→ Phase 6 (Tests)
Phase 4 (States) ───┘
                    
Phase 6 (Tests) → Phase 7 (Polish)
```

**Parallelisation possible** :
- Phase 2 ET Phase 3 peuvent se faire en parallèle
- Différents Components (T030, T031) en parallèle
- Différents States (T040, T041) en parallèle
- Tests unitaires (T060, T061) en parallèle

---

## 📊 Métriques de Progression

**Estimation** : [X] heures total
- Phase 0 : [Y] heures
- Phase 1 : [Y] heures
- Phase 2 : [Y] heures
- Phase 3 : [Y] heures
- Phase 4 : [Y] heures
- Phase 5 : [Y] heures
- Phase 6 : [Y] heures
- Phase 7 : [Y] heures

**Jalons** :
- [ ] **Jalon 1** : Data Layer complet (fin Phase 1)
- [ ] **Jalon 2** : Components testés (fin Phase 3 + Tests T060-T061)
- [ ] **Jalon 3** : Feature fonctionnelle (fin Phase 5)
- [ ] **Jalon 4** : Validé et optimisé (fin Phase 7)

---

## 📝 Notes

- Commiter après chaque phase complétée
- Si blocage, revenir au plan.md et spec.md
- Tester fréquemment, ne pas attendre Phase 6
- Documenter les décisions techniques dans commit messages
