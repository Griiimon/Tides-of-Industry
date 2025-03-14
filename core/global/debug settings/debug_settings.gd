extends Node

@export var enable: bool= false
@export var initial_construction_points: int
@export var only_allow_buildings_in_list: bool= true
@export var unlock_all_buildings: bool= false
@export var all_raw_materials_appear: bool= false
@export var disable_terrain_connect: bool= false
@export var max_out_policies: Array[BasePolicy]



func _ready() -> void:
	if not is_enabled(): return
	
	late_ready.call_deferred()


func late_ready():
	var empire_state: EmpireState= GameData.get_empire_state()
	empire_state.construction_points= initial_construction_points
	if unlock_all_buildings:
		for building in GameData.buildings:
			empire_state.unlock_building(BuildingTier.new(building, building.get_max_level()))
		# to update building list:
		SignalManager.technology_researched.emit(null)

	for policy in max_out_policies:
		policy.level= 9


func is_enabled()-> bool:
	return enable
