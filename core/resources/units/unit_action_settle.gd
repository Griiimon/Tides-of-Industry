class_name UnitActionSettle
extends BaseUnitAction



func execute(unit: UnitInstance)-> bool:
	var island: IslandInstance= unit.world.settle_island(unit.tile_pos)

	island.build(GameData.town_center, 0, unit.tile_pos)
	SignalManager.building_constructed.emit(unit.tile_pos)
	unit.kill()
	return false


func can_execute(unit: UnitInstance)-> bool:
	return GameData.town_center.evaluate_placement_conditions(unit.tile_pos, unit.world, null)
