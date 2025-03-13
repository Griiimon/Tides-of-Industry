class_name BuildingCategoryNeighborBlacklistPlacementCondition
extends BaseBuildingPlacementCondition

@export var blacklist_category: BuildingCategory
@export var allow_same: bool= true



func evaluate(tile: Vector2i, building: Building, world: World, island: IslandInstance)-> bool:
	for neighbor_tile in world.get_surrounding_cells(tile):
		var neighbor_building: Building= world.get_building(neighbor_tile)
		if neighbor_building:
			if neighbor_building.category == blacklist_category:
				if not allow_same or building != neighbor_building:
					return false
	return true
