class_name [Nom]State
extends Node

## État [Nom] pour State Machine.
## 
## Représente l'état où l'entité est [description du comportement].
## 
## Responsabilités :
##   - Gérer le comportement pendant cet état
##   - Décider quand transitionner vers un autre état
##   - Nettoyer à la sortie de l'état
## 
## Communication avec State Machine :
##   - state_machine.change_state("[NomAutreEtat]") pour transitionner
##   - state_machine.owner pour accéder à l'entité propriétaire
## 
## Lifecycle :
##   enter() -> update()/physics_update() (en boucle) -> exit()
## 
## Utilisation :
##   1. Créer comme enfant d'un nœud StateMachine
##   2. La StateMachine appellera les méthodes automatiquement
##   3. Ne PAS instancier ou appeler directement
## 
## Exemple de transition :
##   func update(delta: float) -> void:
##       if condition_remplie:
##           state_machine.change_state("IdleState")

#region Propriétés Exportées
@export_group("Configuration État")
## Temps minimum dans cet état avant de pouvoir transitionner (secondes)
@export var min_duration: float = 0.0

@export_group("Débogage")
## Affiche des logs quand l'état est actif
@export var debug_mode: bool = false
#endregion

#region Propriétés Publiques
## Référence vers la State Machine parente
var state_machine: Node = null

## Référence vers l'entité propriétaire (via state_machine.owner)
var owner_entity: Node = null

## Temps passé dans cet état (secondes)
var time_in_state: float = 0.0
#endregion

#region Propriétés Privées
var _can_exit: bool = false
var _cached_components: Dictionary = {}
#endregion

#region Lifecycle État
## Appelé une fois quand on entre dans cet état.
## Utiliser pour :
##   - Initialiser les variables d'état
##   - Démarrer des animations
##   - Activer/désactiver des Components
##   - Logger l'entrée dans l'état
func enter() -> void:
	time_in_state = 0.0
	_can_exit = min_duration <= 0.0
	
	# Cacher les Components nécessaires au premier accès
	_cache_components()
	
	if debug_mode:
		print("[État: %s] ENTER - Entité: %s" % [name, owner_entity.name if owner_entity else "null"])
	
	# ===== LOGIQUE D'ENTRÉE SPÉCIFIQUE =====
	# TODO: Ajouter la logique d'initialisation de cet état
	# Exemples :
	#   - Démarrer animation idle
	#   - Réinitialiser velocity à zéro
	#   - Activer/désactiver Components
	pass

## Appelé une fois quand on sort de cet état.
## Utiliser pour :
##   - Nettoyer l'état
##   - Arrêter des animations
##   - Restaurer des valeurs
##   - Logger la sortie de l'état
func exit() -> void:
	if debug_mode:
		print("[État: %s] EXIT - Temps passé: %.2fs" % [name, time_in_state])
	
	# ===== LOGIQUE DE SORTIE SPÉCIFIQUE =====
	# TODO: Ajouter la logique de nettoyage
	# Exemples :
	#   - Arrêter animations
	#   - Réinitialiser flags
	pass

## Appelé chaque frame (_process).
## Utiliser pour :
##   - Logique de jeu non-physique
##   - Transitions conditionnelles
##   - Timers
## @param delta: Temps écoulé depuis la dernière frame (secondes)
func update(delta: float) -> void:
	time_in_state += delta
	
	# Activer la possibilité de sortir après min_duration
	if not _can_exit and time_in_state >= min_duration:
		_can_exit = true
	
	# ===== LOGIQUE UPDATE SPÉCIFIQUE =====
	# TODO: Ajouter la logique de mise à jour de cet état
	# Exemples :
	#   - Vérifier conditions de transition
	#   - Mettre à jour des timers
	#   - Logique IA
	
	# Exemple de transition :
	# if _can_exit and _should_transition_to_idle():
	#     state_machine.change_state("IdleState")
	pass

## Appelé chaque frame physique (_physics_process).
## Utiliser pour :
##   - Mouvements physiques
##   - Détection de collision
##   - Forces et vélocités
## @param delta: Temps écoulé depuis la dernière frame physique (fixe, généralement 1/60)
func physics_update(delta: float) -> void:
	# ===== LOGIQUE PHYSIQUE SPÉCIFIQUE =====
	# TODO: Ajouter la logique physique de cet état
	# Exemples :
	#   - Appliquer mouvement
	#   - Gérer gravité
	#   - move_and_slide() si CharacterBody
	pass
#endregion

#region Input Handling (optionnel)
## Appelé quand un input est détecté (_input).
## Override si l'état doit réagir aux inputs.
## @param event: Événement d'input
func handle_input(event: InputEvent) -> void:
	# ===== GESTION INPUT SPÉCIFIQUE =====
	# Exemples :
	# if event.is_action_pressed("jump"):
	#     state_machine.change_state("JumpState")
	pass
#endregion

#region Conditions de Transition (privées)
## Exemples de méthodes pour vérifier les conditions de transition.
## À adapter selon les besoins de l'état.

## Vérifie si on devrait transitionner vers IdleState.
## @return: true si condition remplie
func _should_transition_to_idle() -> bool:
	# Exemple : vérifier la vélocité
	# if owner_entity.velocity.length() < 0.1:
	#     return true
	return false

## Vérifie si on devrait transitionner vers un autre état.
func _should_transition_to_[AutreEtat]() -> bool:
	# Implémenter la logique de transition
	return false
#endregion

#region Méthodes Utilitaires Privées
## Cache les références aux Components fréquemment utilisés.
## Optimisation pour éviter les appels get_node() répétés.
func _cache_components() -> void:
	if not owner_entity:
		return
	
	# Exemples de Components à cacher
	if owner_entity.has_node("Components/HealthComponent"):
		_cached_components["health"] = owner_entity.get_node("Components/HealthComponent")
	
	if owner_entity.has_node("Components/MovementComponent"):
		_cached_components["movement"] = owner_entity.get_node("Components/MovementComponent")

## Récupère un Component caché.
## @param component_name: Nom du Component (clé dans _cached_components)
## @return: Component ou null
func _get_component(component_name: String) -> Node:
	return _cached_components.get(component_name, null)
#endregion
