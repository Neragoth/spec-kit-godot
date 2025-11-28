class_name [Nom]Component
extends Node

## Component [description de la responsabilité unique].
## 
## Ce Component encapsule la logique pour [fonctionnalité spécifique].
## 
## Responsabilité Unique (Single Responsibility Principle) :
##   Ce Component gère UNIQUEMENT [X]. Toute autre logique doit
##   être dans un Component séparé.
## 
## Communication :
##   - Entrée : Via méthodes publiques et setup()
##   - Sortie : Via signaux (découplage fort)
## 
## Utilisation :
##   1. Ajouter comme enfant d'une entité dans la scène
##   2. Appeler setup(entity) depuis l'entité parente
##   3. Connecter aux signaux pour réagir aux événements
##   4. Appeler l'API publique pour déclencher des actions
## 
## Exemple :
##   # Dans l'entité parente
##   @onready var health_comp = $Components/HealthComponent
##   
##   func _ready():
##       health_comp.setup(self)
##       health_comp.damage_taken.connect(_on_damage_taken)
##   
##   func attack():
##       health_comp.take_damage(10.0)

#region Constantes
## Valeurs constantes spécifiques à ce Component
const UPDATE_INTERVAL: float = 0.1
#endregion

#region Signaux
## Émis quand [événement important 1]
## @param value: Description du paramètre
signal value_changed(value: float)

## Émis quand [événement important 2]
signal action_completed()

## Émis en cas d'erreur
signal error_occurred(error_message: String)
#endregion

#region Propriétés Exportées
@export_group("Configuration")
## Active/désactive le Component
@export var is_enabled: bool = true

## Multiplicateur de [effet]
@export_range(0.1, 10.0, 0.1) var multiplier: float = 1.0

@export_group("Débogage")
## Affiche des logs de débogage
@export var debug_mode: bool = false
#endregion

#region Propriétés Publiques
## Référence vers l'entité propriétaire
var owner_entity: Node = null

## Dernier résultat de l'opération
var last_result: Variant = null
#endregion

#region Propriétés Privées
var _current_value: float = 0.0
var _is_processing: bool = false
var _update_timer: float = 0.0
var _cached_data: Dictionary = {}
#endregion

#region Lifecycle Godot
func _ready() -> void:
	# Ne PAS appeler setup() ici, c'est à l'entité parente de le faire
	# Initialisation légère uniquement
	_reset_state()

func _process(delta: float) -> void:
	if not is_enabled or not owner_entity:
		return
	
	_update_timer += delta
	if _update_timer >= UPDATE_INTERVAL:
		_periodic_update()
		_update_timer = 0.0

func _exit_tree() -> void:
	_cleanup()
#endregion

#region Setup & Initialization
## Configure le Component avec son entité propriétaire.
## DOIT être appelé par l'entité parente dans _ready().
## @param entity: Le nœud parent propriétaire de ce Component
func setup(entity: Node) -> void:
	if owner_entity != null:
		push_warning("[%s] setup() appelé plusieurs fois !" % name)
		return
	
	owner_entity = entity
	_initialize_from_entity()
	
	if debug_mode:
		print("[%s] Component configuré pour entité: %s" % [name, entity.name])

## Initialise le Component avec les données de l'entité.
## Appelé automatiquement par setup().
func _initialize_from_entity() -> void:
	# Récupérer les données depuis l'entité si elle a une Resource
	if owner_entity.has_method("get_entity_data"):
		var data = owner_entity.get_entity_data()
		_load_from_data(data)
	
	# Connecter aux signaux de l'entité si nécessaire
	if owner_entity.has_signal("state_changed"):
		owner_entity.state_changed.connect(_on_owner_state_changed)
#endregion

#region API Publique
## [Action principale du Component].
## @param amount: Quantité/valeur pour l'action
## @param source: Source optionnelle de l'action
func perform_action(amount: float, source: Node = null) -> void:
	if not is_enabled or _is_processing:
		if debug_mode:
			push_warning("[%s] Action ignorée (disabled ou déjà en cours)" % name)
		return
	
	_is_processing = true
	
	# Calcul avec multiplicateur
	var effective_amount = amount * multiplier
	
	# Logique métier
	_current_value += effective_amount
	value_changed.emit(_current_value)
	
	if debug_mode:
		print("[%s] Action effectuée: %s (source: %s)" % [name, effective_amount, source])
	
	_is_processing = false
	action_completed.emit()

## Active le Component.
func enable() -> void:
	is_enabled = true
	if debug_mode:
		print("[%s] Component activé" % name)

## Désactive le Component.
func disable() -> void:
	is_enabled = false
	if debug_mode:
		print("[%s] Component désactivé" % name)

## Réinitialise le Component à son état initial.
func reset() -> void:
	_reset_state()
	if debug_mode:
		print("[%s] Component réinitialisé" % name)
#endregion

#region Méthodes Privées
## Charge la configuration depuis une Resource.
## @param data: Resource contenant les données
func _load_from_data(data: Resource) -> void:
	# Exemple : charger des valeurs depuis le Resource
	if data.has("component_multiplier"):
		multiplier = data.component_multiplier
	
	# Mise en cache de données fréquemment utilisées
	_cached_data = {
		"loaded_at": Time.get_ticks_msec(),
		"data_path": data.resource_path
	}

## Mise à jour périodique (appelé toutes les UPDATE_INTERVAL secondes).
func _periodic_update() -> void:
	# Logique de mise à jour régulière
	pass

## Réinitialise l'état interne.
func _reset_state() -> void:
	_current_value = 0.0
	_is_processing = false
	_update_timer = 0.0
	_cached_data.clear()

## Nettoie les ressources avant destruction.
func _cleanup() -> void:
	# Déconnecter les signaux si nécessaire
	if owner_entity and owner_entity.is_connected("state_changed", _on_owner_state_changed):
		owner_entity.state_changed.disconnect(_on_owner_state_changed)
	
	owner_entity = null
	_cached_data.clear()
#endregion

#region Callbacks Signaux
## Appelé quand l'état de l'entité propriétaire change.
## @param old_state: État précédent
## @param new_state: Nouvel état
func _on_owner_state_changed(old_state: Variant, new_state: Variant) -> void:
	if debug_mode:
		print("[%s] Entité a changé d'état: %s -> %s" % [name, old_state, new_state])
	
	# Réagir au changement d'état si nécessaire
	# Ex: désactiver le Component dans certains états
	if new_state == "DEAD":
		disable()
#endregion
