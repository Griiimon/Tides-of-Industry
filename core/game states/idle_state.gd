class_name GameStateIdle
extends GameStateMachineState

signal start_construction

var current_tile: Vector2i



func _ready() -> void:
	super()
	SignalManager.camera_moved.connect(update_current_tile_check)


func on_enter():
	current_tile= state_machine.world.get_mouse_tile()
	SignalManager.show_tile_info.emit(current_tile)


func on_exit():
	SignalManager.hide_tile_info.emit()


func on_unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		update_current_tile_check()

	elif event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					state_machine.world.handle_tile_click()
					return
	
	if event.is_action("build_mode") and event.is_pressed():
		get_viewport().set_input_as_handled()
		start_construction.emit()


func update_current_tile_check():
	if not is_current_state(): return
	
	var new_tile: Vector2i= state_machine.world.get_mouse_tile()
	if new_tile != current_tile:
		current_tile= new_tile
		SignalManager.show_tile_info.emit(current_tile)
