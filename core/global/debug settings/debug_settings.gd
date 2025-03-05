extends Node

@export var enable: bool= false
@export var initial_construction_points: int
@export var only_allow_buildings_in_list: bool= true



func _ready() -> void:
	if not is_enabled(): return
	
	late_ready.call_deferred()


func late_ready():
	GameData.get_empire_state().construction_points= initial_construction_points


func is_enabled()-> bool:
	return enable
