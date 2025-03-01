class_name WorldGenerator
extends Resource



func get_terrain(coords: Vector2i)-> Terrain:
	return null


func get_terrain_feature(coords: Vector2i, terrain: Terrain, rng: RandomNumberGenerator)-> TerrainFeature:
	for feature in GameData.terrain_features:
		var chance: float= feature.occurrence.evaluate(coords, terrain)
		if RngUtils.chancef_rng(chance, rng):
			return feature
	return null
