class_name BuildingStatNeighborBuildingPercentageModifier
extends BuildingStatPercentageModifier

@export var buildings: Array[Building]



func update(tile: Vector2i, world: World, island: IslandInstance):
	var arr: Array[Vector2i]= world.get_neighbor_buildings(tile, buildings)
	update_n_times(arr.size())
