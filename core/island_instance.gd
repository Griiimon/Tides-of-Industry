class_name IslandInstance
extends Node2D

var definition: Island

var world: World
var buildings: Array[Vector2i]
var features: Array[Vector2i]


var pollution: int
var population: int
var production: int
var power: int
var research: int



func update_stats():
	update_pollution()
	update_population()
	update_production()
	update_power()
	update_research()

	SignalManager.island_stats_updated.emit(self)


func build(building: Building, tile: Vector2i):
	world.spawn_building(building, tile)
	buildings.append(tile)
	
	if building.is_town_center():
		definition.add_town_center_position(tile)

	update_stats()


func update_pollution():
	pollution= 0
	for building_pos in buildings:
		pollution+= world.get_building_stat(Building.Stat.POLLUTION, building_pos)


func update_population():
	population= 0
	for building_pos in buildings:
		population+= world.get_building_stat(Building.Stat.POPULATION, building_pos)


func update_production():
	production= 0
	for building_pos in buildings:
		production+= world.get_building_stat(Building.Stat.PRODUCTION, building_pos)


func update_power():
	power= 0
	for building_pos in buildings:
		power+= world.get_building_stat(Building.Stat.POWER, building_pos)


func update_research():
	research= 0
	for building_pos in buildings:
		research+= world.get_building_stat(Building.Stat.RESEARCH, building_pos)


func is_in_town_center_radius(tile: Vector2i)-> bool:
	for town_center_pos in definition.town_center_positions:
		if tile.distance_to(town_center_pos) <= world.get_town_center_radius(town_center_pos):
			return true
	return false
