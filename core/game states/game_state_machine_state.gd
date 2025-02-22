class_name GameStateMachineState
extends StateMachineState

var state_machine: GameStateMachine


func _ready() -> void:
	state_machine= get_parent()


func on_process(delta: float):
	var scroll_vec: Vector2= Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	state_machine.camera.scroll(scroll_vec, delta)
