class_name BuildingStatSameNeighborBuildingPercentageModifier
extends BuildingStatPercentageModifier



func apply(base_value: int, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	var building: Building= world.get_building(tile)
	var arr: Array[Vector2i]= world.get_neighbor_buildings(tile, [building])
	return apply_n_times(arr.size(), base_value, tile, world, island)
