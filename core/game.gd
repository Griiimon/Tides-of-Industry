class_name Game
extends Node2D

@onready var world: World = $World
@onready var game_states: GameStateMachine = $"Game States"
@onready var turn_cooldown: Timer = $"Turn Cooldown Timer"

var is_paused: bool= true:
	set(b):
		is_paused= b
		if not is_inside_tree(): return
		update_turn_cooldown()



func _ready() -> void:
	SignalManager.player_unit_move_finished.connect(on_player_unit_move_finished)
	turn_cooldown.timeout.connect(on_turn_cooldown_timeout)
	
	late_ready.call_deferred()


func late_ready():
	pre_turn()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		if event.is_action("ui_cancel"):
			get_tree().quit()


func next_turn():
	game_states.reset()
	world.tick()

	update_turn_cooldown()
	
	var last_unit: UnitInstance= world.empire.last_used_unit
	if last_unit:
		game_states.select_unit(last_unit)

	pre_turn()


func pre_turn():
	if not game_states.is_unit_selected():
		if world.empire.has_moves_left():
			game_states.select_unit(world.empire.units[0])


func toggle_pause():
	is_paused= not is_paused


func update_turn_cooldown():
	if not is_paused:
		if world.empire.has_moves_left():
			return
		turn_cooldown.start()
	else:
		turn_cooldown.stop()


func on_player_unit_move_finished(_unit: UnitInstance):
	for unit in world.empire.units:
		if unit.has_moves_left():
			game_states.select_unit(unit)
			return
	
	if GameData.user_settings.auto_end_turns or not is_paused:
		next_turn()


func on_turn_cooldown_timeout():
	next_turn()
