extends Node

@export var enabled: bool= true
@export var enable_buildings: bool= false
@export var enable_units: bool= false

@export var clear_tilemaps: bool= true

@export var game_states: GameStateMachine
@export var world: World

@export var town_center: Building



func _ready() -> void:
	if not enabled: return
	late_ready.call_deferred()


func late_ready():
	if clear_tilemaps:
		world.clear_tilemaps()

	var tile:= Vector2i.ZERO
	
# ------- BUILDINGS ------------
	if enable_buildings:
		game_states.world.settle_island(tile).build(town_center, 0, tile)
	
# ------- UNITS ------------
	if enable_units:
		world.spawn_unit(load("res://data/units/explorer.tres"), Vector2i(20, 25))
		#var engineer: UnitInstance= world.spawn_unit(load("res://data/units/engineer.tres"), Vector2i(1, 7))
		#engineer.action_points_left= 100000

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var key_event: InputEventKey= event
		match key_event.keycode:
			KEY_F1:
				print(get_viewport().get_camera_2d().get_screen_center_position())
			KEY_H:
				game_states.build(load("res://data/buildings/house.tres"))
