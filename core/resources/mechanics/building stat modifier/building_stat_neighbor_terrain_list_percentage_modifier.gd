class_name BuildingStatNeighborTerrainListPercentageModifier
extends BuildingStatPercentageModifier

@export var terrains: Array[Terrain]



func apply(base_value: int, tile: Vector2i, world: World, island: IslandInstance)-> int:
	var arr: Array[Vector2i]= world.get_neighbor_terrains(tile, terrains)
	return apply_n_times(arr.size(), base_value, tile, world, island)
