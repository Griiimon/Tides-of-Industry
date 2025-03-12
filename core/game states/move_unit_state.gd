class_name GameStateMoveUnit
extends GameStateMachineState

signal other_unit_selected(unit: UnitInstance)

var unit: UnitInstance



func _ready() -> void:
	super()
	SignalManager.player_unit_deselected.connect(on_unit_deselected)
	SignalManager.unit_removed.connect(on_unit_removed)


func on_enter():
	state_machine.camera.scroll_to(state_machine.world.get_global_pos(unit.tile_pos))
	state_machine.world.set_unit_selection_box(unit.tile_pos)
	SignalManager.player_unit_selected.emit(unit)
	SignalManager.show_tile_info.emit(unit.tile_pos)
	

func on_exit():
	state_machine.world.reset_unit_selection_boxes()
	SignalManager.player_unit_deselected.emit(unit)
	unit= null


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
		else:
			var move_vec: Vector2i
			if event.is_action("unit_move_up"):
				move_vec.y= -1
			elif event.is_action("unit_move_up_right"):
				move_vec.x= 1
				move_vec.y= -1
			elif event.is_action("unit_move_right"):
				move_vec.x= 1
			elif event.is_action("unit_move_down_right"):
				move_vec.x= 1
				move_vec.y= 1
			elif event.is_action("unit_move_down"):
				move_vec.y= 1
			elif event.is_action("unit_move_down_left"):
				move_vec.x= -1
				move_vec.y= 1
			elif event.is_action("unit_move_left"):
				move_vec.x= -1
			elif event.is_action("unit_move_up_left"):
				move_vec.x= -1
				move_vec.y= -1

			if move_vec:
				try_to_move_to(unit.tile_pos + move_vec)


func try_to_move_to(target_pos: Vector2i):
	if unit.can_move_to(target_pos):
		unit.move_to(target_pos)
		SignalManager.player_unit_moved.emit(unit)
		if unit.moves_left == 0:
			finished.emit()
			SignalManager.player_unit_move_finished.emit(unit)
			UnitActionMove.new().execute(unit)
		else:
			state_machine.world.set_unit_selection_box(unit.tile_pos)


func on_unit_deselected(unit: UnitInstance):
	if is_current_state() and not is_exiting:
		finished.emit()


func on_unit_removed(removed_unit: UnitInstance):
	if is_current_state() and unit == removed_unit:
		finished.emit()
