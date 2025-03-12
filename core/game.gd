class_name Game
extends Node2D

const DEFAULT_GAME_SPEED_INTERVAL= 1.0
const FAST_GAME_SPEED_INTERVAL= 0.2

@onready var world: World = $World
@onready var game_states: GameStateMachine = $"Game States"
@onready var turn_cooldown: Timer = $"Turn Cooldown Timer"

var is_paused: bool= true:
	set(b):
		is_paused= b
		if not is_inside_tree(): return
		update_turn_cooldown()

var is_forcing_pause: bool= false: set= set_is_forcing_pause



func _ready() -> void:
	SignalManager.player_unit_move_finished.connect(on_player_unit_move_finished)
	SignalManager.force_pause.connect(set_is_forcing_pause.bind(true))
	SignalManager.cancel_forced_pause.connect(set_is_forcing_pause.bind(false))
	turn_cooldown.timeout.connect(on_turn_cooldown_timeout)
	
	late_ready.call_deferred()


func late_ready():
	pre_turn()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		if event.is_action("ui_cancel"):
			get_tree().quit()
		elif event.is_action("toggle_game_speed"):
			turn_cooldown.wait_time= FAST_GAME_SPEED_INTERVAL if is_equal_approx(turn_cooldown.wait_time, DEFAULT_GAME_SPEED_INTERVAL) else FAST_GAME_SPEED_INTERVAL

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


func set_is_forcing_pause(b):
	if is_forcing_pause == b: return
	if not is_inside_tree(): return
	is_forcing_pause= b
	turn_cooldown.paused= is_forcing_pause
	

func on_player_unit_move_finished(_unit: UnitInstance):
	for unit in world.empire.units:
		if unit.has_moves_left():
			game_states.select_unit(unit)
			return
	
	if GameData.user_settings.auto_end_turns or not is_paused:
		next_turn()


func on_turn_cooldown_timeout():
	next_turn()
