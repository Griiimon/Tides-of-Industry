class_name GameStateConstruction
extends GameStateMachineState

@export var building: Building
@export var tier: int

var cost: int

var is_valid_position: bool= false:
	set(b):
		if not is_current_state(): return
		is_valid_position= b
		state_machine.world.set_building_ghost_layer_valid(is_valid_position)

var current_tile: Vector2i:
	set(tile):
		if not is_current_state(): return
		current_tile= tile
		var world: World= state_machine.world
		if world.has_building(tile):
			is_valid_position= false
		else:
			is_valid_position= building.evaluate_placement_conditions(tile, world, world.get_island(tile)) 

var info: ConstructionInfo



func on_enter():
	SignalManager.force_pause.emit()
	cost= building.get_cost(tier)
	info= ConstructionInfo.new()
	info.building= building
	info.building_tier= tier
	info.cost= cost
	info.is_valid_position= false
	update_current_tile()


func on_exit():
	state_machine.world.tile_map_buildings_ghost.clear()
	#building= null
	#tier= 0
	info= null
	SignalManager.cancel_forced_pause.emit()


func on_unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		update_current_tile()
	
	elif event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					if is_valid_position and GameData.get_empire_state().has_construction_points(cost):
						build()
						if not event.shift_pressed:
							finished.emit()
						else:
							update_current_tile(true)
							
				MOUSE_BUTTON_RIGHT:
					finished.emit()
					
	elif event.is_action("build_mode") and event.is_pressed():
		finished.emit()


func build():
	var island: IslandInstance
	
	if building.is_town_center():
		island= state_machine.world.settle_island(current_tile)
	else:
		island= state_machine.world.get_island(current_tile)
		assert(island)

	GameData.get_empire_state().spend_construction_points(cost)
	island.build(building, tier, current_tile)


func update_current_tile(force_update: bool= false):
	var new_tile: Vector2i= state_machine.world.get_mouse_tile()
	if new_tile != current_tile or force_update:
		current_tile= new_tile
		state_machine.world.draw_ghost_building(building, tier, current_tile)

		building.update_stats(tier, current_tile, state_machine.world, state_machine.world.get_island(current_tile))
		info.is_valid_position= is_valid_position
		info.stats= state_machine.world.temp_building_log
		SignalManager.display_construction_info.emit(info)
