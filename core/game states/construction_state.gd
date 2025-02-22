class_name GameStateConstruction
extends GameStateMachineState

@export var building: Building
var current_tile: Vector2i



func on_enter():
	update_current_tile()


func on_exit():
	state_machine.world.tile_map_buildings_ghost.clear()


func on_unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		update_current_tile()
	elif event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					build()
					finished.emit()
				MOUSE_BUTTON_RIGHT:
					finished.emit()
	elif event.is_action("build_mode") and event.is_pressed():
		finished.emit()


func build():
	var island: IslandInstance
	
	if building.is_town_center:
		island= state_machine.world.settle_island(current_tile)
	else:
		island= state_machine.world.get_island()
		assert(island)

	island.build(building, current_tile)
	#SignalManager.construction_error.emit("Can only build on settled islands")


func update_current_tile():
	current_tile= state_machine.world.get_mouse_tile()
	state_machine.world.draw_ghost_building(current_tile, building)
