extends Node

@export var enable: bool= false
@export var initial_construction_points: int
@export var only_allow_buildings_in_list: bool= true
@export var unlock_all_buildings: bool= false



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

func is_enabled()-> bool:
	return enable
