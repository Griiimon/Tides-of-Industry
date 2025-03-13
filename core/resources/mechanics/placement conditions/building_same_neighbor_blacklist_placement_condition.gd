class_name BuildingSameNeighborBlacklistPlacementCondition
extends BaseBuildingPlacementCondition


func evaluate(tile: Vector2i, building: Building, world: World, island: IslandInstance)-> bool:
	for neighbor_tile in world.get_surrounding_cells(tile):
		var neighbor_building: Building= world.get_building(neighbor_tile)
		if neighbor_building:
			if building == neighbor_building:
				return false
	return true
