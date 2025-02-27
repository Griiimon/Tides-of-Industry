class_name GameStateMachineState
extends StateMachineState

var state_machine: GameStateMachine


func _ready() -> void:
	state_machine= get_parent()


func on_process(delta: float):
	var scroll_vec: Vector2= Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if scroll_vec:
		state_machine.camera.scroll(scroll_vec, delta)


func handle_unit_click(positive_signal: Signal)-> bool:
	var mouse_tile: Vector2i= state_machine.world.get_mouse_tile()
	var unit: UnitInstance= state_machine.world.get_unit(mouse_tile)
	if unit and not unit.is_ai and unit.has_moves_left():
		positive_signal.emit(unit)
		return true
	return false
