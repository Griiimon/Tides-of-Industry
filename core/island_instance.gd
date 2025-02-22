class_name IslandInstance
extends Node2D

var definition: Island

var world: World
var buildings: Array[Vector2i]
var features: Array[Vector2i]


var pollution: int
var population: int
var production: int
var research: int



func update():
	update_pollution()
	update_population()
	update_production()
	update_research()


func build(building: Building, tile: Vector2i):
	world.spawn_building(building, tile)
	buildings.append(tile)
	
	if building.is_town_center():
		definition.town_center_positions.append(tile)



func update_pollution():
	pollution= 0
	for building_pos in buildings:
		pollution+= world.get_building_stat("pollution", building_pos)


func update_population():
	population= 0
	for building_pos in buildings:
		population+= world.get_building_stat("population", building_pos)


func update_production():
	production= 0
	for building_pos in buildings:
		production+= world.get_building_stat("production", building_pos)


func update_research():
	research= 0
	for building_pos in buildings:
		research+= world.get_building_stat("research", building_pos)


func is_in_town_center_radius(tile: Vector2i)-> bool:
	for town_center_pos in definition.town_center_positions:
		if tile.distance_to(town_center_pos) <= world.get_town_center_radius(town_center_pos):
			return true
	return false
