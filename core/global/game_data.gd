extends Node

@export var terrains: Array[Terrain]
@export var terrain_features: Array[TerrainFeature]
@export var buildings: Array[Building]

var empire: EmpireState= EmpireState.new()
var world_state: WorldState= WorldState.new()

var terrain_set_lookup: Dictionary
var terrain_feature_atlas_lookup: Dictionary
var building_atlas_lookup: Dictionary



func _ready() -> void:
	for terrain in terrains:
		terrain_set_lookup[terrain.terrain_set_name]= terrain

	for terrain_feature in terrain_features:
		terrain_feature_atlas_lookup[terrain_feature.atlas_coords]= terrain_feature

	for building in buildings:
		building_atlas_lookup[building.atlas_coords]= building
