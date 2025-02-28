class_name WorldGeneratorClassic
extends WorldGenerator

@export var land_noise: FastNoiseLite
@export var land_threshold: float= 0.0

@export var forest_noise: FastNoiseLite
@export var forest_threshold: float= 0.3

@export var hills_noise: FastNoiseLite
@export var hills_threshold: float= 0.45

@export var mountains_noise: FastNoiseLite
@export var mountains_threshold: float= 0
@export var mountains_height_threshold: float= 0.5

@export var grass: Terrain
@export var sea: Terrain
@export var hills: Terrain
@export var mountains: Terrain
@export var desert: Terrain
@export var marsh: Terrain
@export var forest: Terrain



func get_terrain(coords: Vector2i)-> Terrain:
	var height: float= land_noise.get_noise_2dv(coords)
	if height > land_threshold:
		if height > mountains_height_threshold:
			if mountains_noise.get_noise_2dv(coords) > mountains_threshold:
				return mountains
		
		if hills_noise.get_noise_2dv(coords) > hills_threshold:
			return hills

		if forest_noise.get_noise_2dv(coords) > forest_threshold:
			return forest


		return grass
	else:
		return sea
