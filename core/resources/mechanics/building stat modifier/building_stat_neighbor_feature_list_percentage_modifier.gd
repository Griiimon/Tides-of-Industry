class_name BuildingStatNeighborFeatureListPercentageModifier
extends BuildingStatPercentageModifier

@export var features: Array[TerrainFeature]



func apply(base_value: int, tile: Vector2i, world: World, island: IslandInstance)-> int:
	var arr: Array[Vector2i]= world.get_neighbor_features(tile, features)
	return apply_n_times(arr.size(), base_value, tile, world, island)
