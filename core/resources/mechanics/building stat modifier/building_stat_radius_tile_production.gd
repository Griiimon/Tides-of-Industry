class_name BuildingStatRadiusTileProduction
extends BuildingStatTileProduction

@export var radius: int



func apply(base_value: int, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	var result: int= base_value
	for worked_tile in world.get_tiles_in_radius(tile, radius, false):
		
		result+= process_tile(worked_tile, building_tier, world, island)
	return result
