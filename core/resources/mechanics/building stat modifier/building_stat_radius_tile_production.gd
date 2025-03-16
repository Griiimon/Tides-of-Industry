class_name BuildingStatRadiusTileProduction
extends BuildingStatTileProduction

@export var radius: int



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, city: CityInstance)-> int:
	var result: int= base_value
	for worked_tile in world.get_tiles_in_radius(tile, radius, false):
		
		result+= process_tile(worked_tile, building, building_tier, world, city)
	return result
