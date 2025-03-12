class_name WorldGeneratorClassic
extends WorldGenerator

@export var land_noise: FastNoiseLite
@export var land_threshold: float= 0.0
@export var deep_sea_threshold: float= -0.2

@export var forest_noise: FastNoiseLite
@export var forest_threshold: float= 0.3

@export var hills_noise: FastNoiseLite
@export var hills_threshold: float= 0.45

@export var mountains_noise: FastNoiseLite
@export var mountains_threshold: float= 0
@export var mountains_height_threshold: float= 0.5

@export var humidity_noise: FastNoiseLite
@export var marsh_humidity_threshold: float
@export var desert_humidity_threshold: float

@export var fertile_humidity_threshold: float
@export var fertile_noise: FastNoiseLite
@export var fertile_noise_threshold: float


@export_subgroup("Terrain assignments")
@export var grass: Terrain
@export var sea: Terrain
@export var hills: Terrain
@export var mountains: Terrain
@export var desert: Terrain
@export var marsh: Terrain
@export var forest: Terrain
@export var deep_sea: Terrain
@export var fertile_ground: Terrain



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

		var humidity: float= humidity_noise.get_noise_2dv(coords)
		if humidity > marsh_humidity_threshold:
			return marsh
		elif humidity > fertile_humidity_threshold:
			print(fertile_noise.get_noise_2dv(coords))
			if fertile_noise.get_noise_2dv(coords) > fertile_noise_threshold:
				return fertile_ground
		elif humidity < desert_humidity_threshold:
			return desert
		
		return grass
	else:
		if height < deep_sea_threshold:
			return deep_sea
		return sea
