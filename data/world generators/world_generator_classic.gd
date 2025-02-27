class_name WorldGeneratorClassic
extends WorldGenerator

@export var land_noise: FastNoiseLite
@export var land_threshold: float= 0.0


func get_terrain(coords: Vector2i)-> Terrain:
	if land_noise.get_noise_2dv(coords) > land_threshold:
		return load("res://data/terrain/grasslands.tres")
	else:
		return load("res://data/terrain/sea.tres")
