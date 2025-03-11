class_name BuildingStatNeighborTileProduction
extends BuildingStatTileProduction



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	var result: int= base_value
	for worked_tile in World.get_surrounding_cells(tile):
		result+= process_tile(worked_tile, building_tier, world, island)
	return result
