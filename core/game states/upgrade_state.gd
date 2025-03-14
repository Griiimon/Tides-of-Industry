class_name GameStateUpgrade
extends GameStateMachineState



func on_enter():
	SignalManager.force_pause.emit()


func on_exit(re_enter_same_state: bool):
	SignalManager.cancel_forced_pause.emit()


func on_unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		if event is InputEventMouseButton:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					get_viewport().set_input_as_handled()
					var world: World= state_machine.world
					var mouse_tile: Vector2i= world.get_mouse_tile()
					if not world.has_building(mouse_tile): return
					
					var building: Building= world.get_building(mouse_tile)
					var tier: int= world.get_building_level(mouse_tile)
					if not building.can_upgrade_from(tier): return

					var empire_state: EmpireState= GameData.get_empire_state()
					if not empire_state.is_building_unlocked(BuildingTier.new(building, tier + 1)):
						return

					var upgrade_cost: int= building.get_upgrade_cost(tier)
					if not empire_state.has_construction_points(upgrade_cost):
						return
					
					empire_state.spend_construction_points(upgrade_cost)
					world.upgrade_building(mouse_tile)
				#MOUSE_BUTTON_RIGHT:
					#get_viewport().set_input_as_handled()
					#finished.emit()
