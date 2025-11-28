class_name [NomClasse]
extends [ClasseParente]

## Classe abstraite de base pour [description du rôle].
## Définit le contrat que toutes les classes dérivées doivent respecter.
## 
## Utilisation :
##   - Créer une classe concrète qui étend cette classe
##   - Implémenter toutes les méthodes marquées @abstract
##   - Override les méthodes virtuelles si nécessaire
##
## Exemple :
##   class_name MonEntity
##   extends Base[Nom]
##   
##   func initialize(data: [Type]Data) -> void:
##       # Implémentation spécifique
##       pass
@abstract

#region Constantes
## Constantes partagées par toutes les classes dérivées
const MAX_INSTANCES: int = 100
#endregion

#region Énumérations
## États possibles (adapter selon le contexte)
enum State {
	IDLE,
	ACTIVE,
	DISABLED
}
#endregion

#region Signaux
## Émis quand l'instance est initialisée
signal initialized()

## Émis quand l'état change
signal state_changed(old_state: State, new_state: State)
#endregion

#region Propriétés Exportées
## Resource contenant les données de configuration
@export var config_data: Resource

@export_group("Débogage")
## Active les logs de débogage
@export var enable_debug: bool = false
#endregion

#region Propriétés Publiques
## État actuel de l'instance
var current_state: State = State.IDLE
#endregion

#region Propriétés Privées
var _is_initialized: bool = false
var _internal_timer: float = 0.0
#endregion

#region Méthodes Abstraites (DOIVENT être implémentées)
## Initialise l'instance avec les données fournies.
## Appelé automatiquement par _ready() si config_data est défini.
## @param data: Resource de configuration
@abstract
func initialize(data: Resource) -> void:
	pass

## Met à jour la logique principale de l'instance.
## Appelé par _process() si l'instance est initialisée.
## @param delta: Temps écoulé depuis la dernière frame
@abstract
func update_logic(delta: float) -> void:
	pass

## Nettoie les ressources avant destruction.
## Appelé automatiquement par _exit_tree().
@abstract
func cleanup() -> void:
	pass
#endregion

#region Méthodes Virtuelles (peuvent être overridées)
## Appelé juste après l'initialisation réussie.
## Override pour ajouter une logique post-init.
func on_initialized() -> void:
	pass

## Appelé quand l'état change.
## Override pour réagir aux changements d'état.
## @param old: État précédent
## @param new: Nouvel état
func on_state_changed(old: State, new: State) -> void:
	pass
#endregion

#region Lifecycle Godot
func _ready() -> void:
	if config_data:
		initialize(config_data)
		_is_initialized = true
		initialized.emit()
		on_initialized()
	else:
		push_error("[%s] config_data non défini !" % name)

func _process(delta: float) -> void:
	if not _is_initialized:
		return
	
	update_logic(delta)
	
	if enable_debug:
		_debug_update(delta)

func _exit_tree() -> void:
	cleanup()
#endregion

#region API Publique
## Change l'état actuel de l'instance.
## Émet le signal state_changed.
## @param new_state: Nouvel état
func change_state(new_state: State) -> void:
	if current_state == new_state:
		return
	
	var old_state = current_state
	current_state = new_state
	state_changed.emit(old_state, new_state)
	on_state_changed(old_state, new_state)
	
	if enable_debug:
		print("[%s] État changé: %s -> %s" % [name, State.keys()[old_state], State.keys()[new_state]])

## Vérifie si l'instance est correctement initialisée.
## @return: true si initialisée, false sinon
func is_ready() -> bool:
	return _is_initialized
#endregion

#region Méthodes Privées
## Affiche des informations de débogage.
## @param delta: Temps écoulé
func _debug_update(delta: float) -> void:
	_internal_timer += delta
	if _internal_timer >= 1.0:
		print("[%s DEBUG] État: %s" % [name, State.keys()[current_state]])
		_internal_timer = 0.0
#endregion
