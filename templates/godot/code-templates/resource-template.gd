class_name [Nom]Data
extends Resource

## Resource de données pour [description de l'entité/système].
## 
## Ce Resource définit TOUTES les propriétés configurables pour [entité].
## AUCUNE logique métier ici, uniquement des données déclaratives.
## 
## Utilisation :
##   1. Créer un fichier .tres basé sur cette classe
##   2. Configurer les propriétés dans l'éditeur Godot
##   3. Charger avec: var data = load("res://data/[category]/[nom].tres")
##   4. Passer aux scripts qui en ont besoin
## 
## Exemple d'instance .tres :
##   res://data/entities/player_default.tres
##   res://data/entities/enemy_goblin.tres

#region Metadata
## Version du format de données (pour migrations futures)
const DATA_VERSION: int = 1

## Catégorie de ce Resource (utile pour filtrage/recherche)
@export_enum("Entity", "Item", "Ability", "Config") var category: String = "Entity"
#endregion

#region Stats de Base
@export_group("Stats de Base")

## Points de vie maximum
@export_range(1, 10000, 1) var max_health: float = 100.0

## Vitesse de déplacement (unités/seconde)
@export_range(0.1, 100.0, 0.1) var move_speed: float = 5.0

## Défense (réduit les dégâts reçus)
@export_range(0, 1000, 1) var defense: float = 10.0
#endregion

#region Apparence Visuelle
@export_group("Apparence")

## Mesh 3D à afficher (si applicable)
@export var mesh: Mesh

## Material appliqué au mesh
@export var material: Material

## Facteur d'échelle visuelle
@export_range(0.1, 10.0, 0.1) var scale_factor: float = 1.0

## Couleur de teinte (appliquée au material)
@export_color_no_alpha var tint_color: Color = Color.WHITE
#endregion

#region Comportement & AI
@export_group("Comportement")

## Resource définissant le comportement IA (si applicable)
## Peut être null pour entités contrôlées par le joueur
@export var ai_behavior: Resource # Type: AIBehaviorData

## Table de loot (objets droppés à la mort)
## Peut être null si aucun loot
@export var loot_table: Resource # Type: LootTableData

## Agressivité (0 = passif, 100 = très agressif)
@export_range(0, 100, 1) var aggression: int = 50
#endregion

#region Compétences & Abilities
@export_group("Compétences")

## Liste des compétences disponibles
## Chaque élément est une AbilityData Resource
@export var abilities: Array[Resource] = [] # Type: Array[AbilityData]

## Temps de recharge global entre compétences (secondes)
@export_range(0, 10, 0.1) var global_cooldown: float = 1.0
#endregion

#region Audio
@export_group("Audio")

## Son joué au spawn
@export var spawn_sound: AudioStream

## Son joué à la mort
@export var death_sound: AudioStream

## Sons d'impact/dégâts
@export var damage_sounds: Array[AudioStream] = []
#endregion

#region Tags & Metadata
@export_group("Métadonnées")

## Tags pour identification et filtrage
## Ex: ["enemy", "boss", "undead"]
@export var tags: Array[String] = []

## Nom affichable (localisable)
@export var display_name: String = ""

## Description (localisable)
@export_multiline var description: String = ""
#endregion

#region Validation
## Valide les données au chargement du Resource.
## Godot appelle cette fonction pour chaque propriété.
## Utiliser pour des vérifications et logs d'erreurs.
func _validate_property(property: Dictionary) -> void:
	# Validation max_health
	if property.name == "max_health":
		if max_health <= 0:
			push_error("[%s] max_health doit être > 0, valeur actuelle: %s" % [resource_path, max_health])
	
	# Validation move_speed
	if property.name == "move_speed":
		if move_speed < 0:
			push_error("[%s] move_speed ne peut pas être négatif" % resource_path)
	
	# Validation abilities
	if property.name == "abilities":
		for ability in abilities:
			if ability == null:
				push_warning("[%s] abilities contient une référence null" % resource_path)

## Appelé quand le Resource est chargé.
## Utiliser pour initialisation ou validation complexe.
func _init() -> void:
	# Initialisation par défaut si nécessaire
	if display_name.is_empty():
		display_name = resource_path.get_file().get_basename()
#endregion

#region Méthodes Utilitaires
## Vérifie si un tag spécifique est présent.
## @param tag: Tag à rechercher
## @return: true si le tag existe
func has_tag(tag: String) -> bool:
	return tag in tags

## Clone ce Resource avec toutes ses sous-resources.
## @return: Nouvelle instance avec valeurs identiques
func deep_duplicate() -> [Nom]Data:
	var dup = duplicate(true) as [Nom]Data
	
	# Dupliquer les Resources imbriquées si nécessaire
	if ai_behavior:
		dup.ai_behavior = ai_behavior.duplicate(true)
	if loot_table:
		dup.loot_table = loot_table.duplicate(true)
	
	# Dupliquer l'array d'abilities
	dup.abilities = []
	for ability in abilities:
		if ability:
			dup.abilities.append(ability.duplicate(true))
	
	return dup
#endregion
