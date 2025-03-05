class_name BuildingStatNeighborTileProduction
extends BuildingStatTileProduction



func apply(base_value: int, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	var result: int= base_value
	for worked_tile in world.get_neighbor_tiles(tile):
		result+= process_tile(worked_tile, building_tier, world, island)
	return result
