extends Node2D

@onready var world: World = $World
@onready var game_states: GameStateMachine = $"Game States"



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
