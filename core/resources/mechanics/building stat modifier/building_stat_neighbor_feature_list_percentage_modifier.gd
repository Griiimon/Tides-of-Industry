class_name BuildingStatNeighborFeatureListPercentageModifier
extends BuildingStatPercentageModifier

@export var features: Array[TerrainFeature]



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, city: CityInstance)-> int:
	var arr: Array[Vector2i]= world.get_neighbor_features(tile, features)
	return apply_n_times(arr.size(), base_value, tile, building_tier, world, city)
