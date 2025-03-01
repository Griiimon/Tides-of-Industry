class_name WorldGenerator
extends Resource



func get_terrain(coords: Vector2i)-> Terrain:
	return null


func get_terrain_feature(coords: Vector2i, terrain: Terrain, rng: RandomNumberGenerator)-> TerrainFeature:
	for feature in GameData.terrain_features:
		var chance: float= feature.occurrence.evaluate(coords, terrain, null)
		if RngUtils.chancef_rng(chance, rng):
			return feature
	return null


func get_raw_material(coords: Vector2i, terrain: Terrain, feature: TerrainFeature, rng: RandomNumberGenerator)-> RawMaterial:
	for raw_material in GameData.raw_materials:
		var chance: float= raw_material.occurrence.evaluate(coords, terrain, feature)
		if RngUtils.chancef_rng(chance, rng):
			return raw_material
	return null
