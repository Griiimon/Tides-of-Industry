extends Node2D

@onready var world: World = $World
@onready var game_states: GameStateMachine = $"Game States"



func _ready() -> void:
	SignalManager.player_unit_move_finished.connect(on_player_unit_move_finished)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		if event.is_action("ui_cancel"):
			get_tree().quit()
		if event.is_action("next_turn"):
			next_turn()
			get_viewport().set_input_as_handled()


func next_turn():
	game_states.reset()
	world.tick()


func on_player_unit_move_finished(_unit: UnitInstance):
	for unit in world.empire.units:
		if unit.has_moves_left():
			game_states.select_unit(unit)
			return
	
	if GameData.user_settings.auto_end_turns:
		next_turn()
