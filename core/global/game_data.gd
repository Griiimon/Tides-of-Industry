extends Node

@export var terrains: Array[Terrain]
@export var terrain_features: Array[TerrainFeature]
@export var buildings: Array[Building]
@export var technologies: Array[Technology]
@export var raw_materials: Array[RawMaterial]
@export var units: Array[Unit]
@export var policies: Array[BasePolicy]

@export var initial_building_unlocks: Array[Building]
@export var town_center: TownCenter


var world_state: WorldState= WorldState.new()
var user_settings: UserSettings= UserSettings.new()

var terrain_set_lookup: Dictionary
var terrain_feature_atlas_lookup: Dictionary
var building_atlas_lookup: Dictionary
var raw_material_atlas_lookup: Dictionary
var unit_atlas_lookup: Dictionary



func _ready() -> void:
	for terrain in terrains:
		terrain_set_lookup[terrain.terrain_set_name]= terrain

	for terrain_feature in terrain_features:
		terrain_feature_atlas_lookup[terrain_feature.atlas_coords]= terrain_feature

	for building in buildings:
		for atlas_coords in building.atlas_coords:
			building_atlas_lookup[atlas_coords]= building

	for raw_material in raw_materials:
		raw_material_atlas_lookup[raw_material.atlas_coords]= raw_material

	for unit in units:
		unit_atlas_lookup[unit.atlas_coords]= unit

	get_empire_state().initialize()


func get_empire_state()-> EmpireState:
	return world_state.empire_state
