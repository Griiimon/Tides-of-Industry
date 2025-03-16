class_name BuildingStatNeighborTerrainListPercentageModifier
extends BuildingStatPercentageModifier

@export var terrains: Array[Terrain]



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, city: CityInstance)-> int:
	var arr: Array[Vector2i]= world.get_neighbor_terrains(tile, terrains)
	return apply_n_times(arr.size(), base_value, tile, building_tier, world, city)


func get_short_desc()-> String:
	return "From Terrain"
