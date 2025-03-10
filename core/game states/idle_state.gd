class_name GameStateIdle
extends GameStateMachineState

signal start_construction
signal unit_selected(unit: UnitInstance)

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

	elif event.is_pressed():
		if event is InputEventMouseButton:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					if handle_tile_click():
						get_viewport().set_input_as_handled()
					return
		
		elif event.is_action("build_mode"):
			get_viewport().set_input_as_handled()
			start_construction.emit()
		elif event.is_action("pause"):
			get_viewport().set_input_as_handled()
			state_machine.game.toggle_pause()
		elif event.is_action("next_turn"):
			get_viewport().set_input_as_handled()
			if state_machine.game.is_forcing_pause: return
			if not state_machine.game.is_paused:
				state_machine.game.is_paused= true
			else:
				state_machine.game.next_turn()


func handle_tile_click()-> bool:
	if handle_unit_click(unit_selected):
		return true
	if handle_building_click():
		return true
	return false


func handle_building_click()-> bool:
	if state_machine.world.has_building(current_tile):
		SignalManager.display_building_log.emit(state_machine.world.building_logs[current_tile])
		return true
	return false


func update_current_tile_check():
	if not is_current_state(): return
	
	var new_tile: Vector2i= state_machine.world.get_mouse_tile()
	if new_tile != current_tile:
		current_tile= new_tile
		SignalManager.show_tile_info.emit(current_tile)
