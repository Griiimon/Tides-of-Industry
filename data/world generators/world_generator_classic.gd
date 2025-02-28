class_name WorldGeneratorClassic
extends WorldGenerator

@export var land_noise: FastNoiseLite
@export var land_threshold: float= 0.0

@export var grass: Terrain
@export var sea: Terrain



func get_terrain(coords: Vector2i)-> Terrain:
	if land_noise.get_noise_2dv(coords) > land_threshold:
		return grass
	else:
		return sea
