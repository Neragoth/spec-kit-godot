extends Node

## Service global pour [description de la fonctionnalité].
## 
## Ce service gère [responsabilité globale] de manière centralisée.
## Accessible globalement via Autoload ou ServiceLocator.
## 
## Pattern : Singleton (Autoload) OU Service Locator
## 
## Configuration Autoload :
##   Project Settings -> Autoload -> Ajouter ce script
##   Nom: [NomService]
##   Chemin: res://core/systems/[nom]_service.gd
##   Activer "Enable"
## 
## Utilisation via Autoload :
##   [NomService].register_item(item)
##   var item = [NomService].get_item(id)
## 
## Utilisation via ServiceLocator :
##   # Dans un autoload d'initialisation
##   ServiceLocator.register_service("[NomService]", [NomService].new())
##   
##   # N'importe où dans le code
##   var service = ServiceLocator.get_service("[NomService]")
##   service.register_item(item)
## 
## Responsabilités :
##   - [Responsabilité 1]
##   - [Responsabilité 2]
##   - [Responsabilité 3]

#region Constantes
## Nom du service pour ServiceLocator (si utilisé)
const SERVICE_NAME: String = "[NomService]"

## Capacité maximale du service
const MAX_CAPACITY: int = 1000
#endregion

#region Signaux
## Émis quand un élément est enregistré
signal item_registered(item_id: String, item: Variant)

## Émis quand un élément est supprimé
signal item_unregistered(item_id: String)

## Émis quand le service est initialisé
signal service_ready()

## Émis en cas d'erreur critique
signal service_error(error_code: int, error_message: String)
#endregion

#region Propriétés Privées
## Registre principal : ID -> Item
var _registry: Dictionary = {}

## Index secondaire pour recherche rapide
var _index_by_type: Dictionary = {}

## Statistiques d'utilisation
var _stats: Dictionary = {
	"total_registered": 0,
	"total_unregistered": 0,
	"current_count": 0
}

## Flag d'initialisation
var _is_initialized: bool = false

## Configuration chargée depuis Resource (optionnel)
var _config: Resource = null
#endregion

#region Lifecycle Godot
func _ready() -> void:
	_initialize_service()

func _exit_tree() -> void:
	_shutdown_service()
#endregion

#region Initialization
## Initialise le service.
## Appelé automatiquement par _ready() si Autoload.
func _initialize_service() -> void:
	if _is_initialized:
		push_warning("[%s] Service déjà initialisé !" % SERVICE_NAME)
		return
	
	# Charger configuration si existe
	var config_path = "res://data/config/%s_config.tres" % SERVICE_NAME.to_lower()
	if ResourceLoader.exists(config_path):
		_config = load(config_path)
		_load_config(_config)
	
	# Initialisation des structures de données
	_registry.clear()
	_index_by_type.clear()
	_reset_stats()
	
	_is_initialized = true
	service_ready.emit()
	
	print("[%s] Service initialisé" % SERVICE_NAME)

## Charge la configuration depuis un Resource.
## @param config: Resource de configuration
func _load_config(config: Resource) -> void:
	# Charger les paramètres depuis le Resource
	# Exemple :
	# if config.has("max_capacity"):
	#     MAX_CAPACITY = config.max_capacity
	pass

## Arrête proprement le service.
func _shutdown_service() -> void:
	if not _is_initialized:
		return
	
	print("[%s] Arrêt du service..." % SERVICE_NAME)
	
	# Nettoyer les ressources
	_registry.clear()
	_index_by_type.clear()
	
	_is_initialized = false
#endregion

#region API Publique - Enregistrement
## Enregistre un élément dans le service.
## @param item_id: Identifiant unique de l'élément
## @param item: L'élément à enregistrer
## @return: true si succès, false sinon
func register_item(item_id: String, item: Variant) -> bool:
	if not _is_initialized:
		push_error("[%s] Service non initialisé !" % SERVICE_NAME)
		return false
	
	if item_id.is_empty():
		push_error("[%s] item_id ne peut pas être vide" % SERVICE_NAME)
		return false
	
	if item_id in _registry:
		push_warning("[%s] item_id '%s' déjà enregistré, remplacement..." % [SERVICE_NAME, item_id])
	
	# Vérifier capacité
	if _registry.size() >= MAX_CAPACITY:
		service_error.emit(1, "Capacité maximale atteinte")
		return false
	
	# Enregistrer
	_registry[item_id] = item
	
	# Indexer par type (si applicable)
	var item_type = _get_item_type(item)
	if not item_type in _index_by_type:
		_index_by_type[item_type] = []
	_index_by_type[item_type].append(item_id)
	
	# Statistiques
	_stats["total_registered"] += 1
	_stats["current_count"] = _registry.size()
	
	item_registered.emit(item_id, item)
	return true

## Désenregistre un élément.
## @param item_id: Identifiant de l'élément à retirer
## @return: true si supprimé, false si non trouvé
func unregister_item(item_id: String) -> bool:
	if not item_id in _registry:
		push_warning("[%s] item_id '%s' non trouvé" % [SERVICE_NAME, item_id])
		return false
	
	var item = _registry[item_id]
	var item_type = _get_item_type(item)
	
	# Retirer du registre principal
	_registry.erase(item_id)
	
	# Retirer de l'index par type
	if item_type in _index_by_type:
		_index_by_type[item_type].erase(item_id)
		if _index_by_type[item_type].is_empty():
			_index_by_type.erase(item_type)
	
	# Statistiques
	_stats["total_unregistered"] += 1
	_stats["current_count"] = _registry.size()
	
	item_unregistered.emit(item_id)
	return true
#endregion

#region API Publique - Accès
## Récupère un élément par son ID.
## @param item_id: Identifiant de l'élément
## @return: L'élément ou null si non trouvé
func get_item(item_id: String) -> Variant:
	return _registry.get(item_id, null)

## Vérifie si un élément existe.
## @param item_id: Identifiant à vérifier
## @return: true si existe
func has_item(item_id: String) -> bool:
	return item_id in _registry

## Récupère tous les éléments d'un type donné.
## @param item_type: Type d'élément (ex: "Enemy", "Item")
## @return: Array d'item_ids
func get_items_by_type(item_type: String) -> Array:
	return _index_by_type.get(item_type, [])

## Récupère tous les éléments enregistrés.
## @return: Dictionary { item_id: item }
func get_all_items() -> Dictionary:
	return _registry.duplicate()

## Compte le nombre d'éléments enregistrés.
## @return: Nombre d'éléments
func get_item_count() -> int:
	return _registry.size()
#endregion

#region API Publique - Opérations
## Effectue une opération sur tous les éléments.
## @param callable: Fonction à appeler pour chaque élément (func(item_id, item))
func foreach_item(callable: Callable) -> void:
	for item_id in _registry:
		callable.call(item_id, _registry[item_id])

## Filtre les éléments selon un prédicat.
## @param predicate: Fonction de test (func(item) -> bool)
## @return: Array d'item_ids qui passent le test
func filter_items(predicate: Callable) -> Array:
	var results: Array = []
	for item_id in _registry:
		if predicate.call(_registry[item_id]):
			results.append(item_id)
	return results

## Nettoie tous les éléments.
func clear_all() -> void:
	var count = _registry.size()
	_registry.clear()
	_index_by_type.clear()
	_reset_stats()
	
	print("[%s] %d éléments supprimés" % [SERVICE_NAME, count])
#endregion

#region Statistiques & Debug
## Récupère les statistiques d'utilisation.
## @return: Dictionary avec statistiques
func get_stats() -> Dictionary:
	return _stats.duplicate()

## Affiche les statistiques dans la console.
func print_stats() -> void:
	print("[%s] Statistiques:" % SERVICE_NAME)
	print("  - Total enregistrés: %d" % _stats["total_registered"])
	print("  - Total désenregistrés: %d" % _stats["total_unregistered"])
	print("  - Actuellement: %d" % _stats["current_count"])
	print("  - Types indexés: %d" % _index_by_type.size())

## Réinitialise les statistiques.
func _reset_stats() -> void:
	_stats = {
		"total_registered": 0,
		"total_unregistered": 0,
		"current_count": 0
	}
#endregion

#region Méthodes Privées
## Détermine le type d'un élément.
## À adapter selon la structure de vos données.
## @param item: L'élément à analyser
## @return: String représentant le type
func _get_item_type(item: Variant) -> String:
	# Stratégie 1 : Utiliser class_name si disponible
	if item is Object and item.get_script():
		var script = item.get_script()
		if script.has_method("get_class"):
			return item.get_class()
	
	# Stratégie 2 : Utiliser typeof() Godot
	match typeof(item):
		TYPE_OBJECT:
			return item.get_class() if item else "Object"
		TYPE_DICTIONARY:
			return item.get("type", "Dictionary")
		_:
			return type_string(typeof(item))
	
	return "Unknown"
#endregion
