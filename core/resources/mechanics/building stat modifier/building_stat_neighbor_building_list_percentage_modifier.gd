class_name BuildingStatNeighborBuildingListPercentageModifier
extends BuildingStatPercentageModifier

@export var buildings: Array[Building]



func apply(base_value: int, tile: Vector2i, world: World, island: IslandInstance)-> int:
	var arr: Array[Vector2i]= world.get_neighbor_buildings(tile, buildings)
	return apply_n_times(arr.size(), base_value, tile, world, island)
