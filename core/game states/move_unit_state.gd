class_name GameStateMoveUnit
extends GameStateMachineState

signal other_unit_selected(unit: UnitInstance)

var unit: UnitInstance



func on_enter():
	state_machine.camera.scroll_to(state_machine.world.get_global_pos(unit.tile_pos))
	state_machine.world.set_unit_selection_box(unit.tile_pos)
	SignalManager.show_tile_info.emit(unit.tile_pos)
	

func on_exit():
	state_machine.world.reset_unit_selection_boxes()


func on_unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		if event is InputEventMouseButton:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					var target_pos: Vector2i= state_machine.world.get_mouse_tile()
					if target_pos == unit.tile_pos:
						return
					if handle_unit_click(other_unit_selected):
						return
					if target_pos.distance_to(unit.tile_pos):
						try_to_move_to(target_pos)
				MOUSE_BUTTON_RIGHT:
					finished.emit()

		elif event.is_action("end_unit_turn"):
			unit.moves_left= 0
			finished.emit()
			SignalManager.player_unit_move_finished.emit(unit)


func try_to_move_to(target_pos: Vector2i):
	if unit.can_move_to(target_pos):
		unit.move_to(target_pos)
		SignalManager.player_unit_moved.emit(unit)
		if unit.moves_left == 0:
			finished.emit()
			SignalManager.player_unit_move_finished.emit(unit)
		else:
			state_machine.world.set_unit_selection_box(unit.tile_pos)
