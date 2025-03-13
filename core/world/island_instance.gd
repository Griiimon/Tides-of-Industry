class_name IslandInstance
extends Node2D

var definition: Island

var world: World
var buildings: Array[Vector2i]
var features: Array[Vector2i]

var pollution: int
var population: int
var base_production: int
var production: int
var power: int
var research: int

var max_workers: int
var workers_ratio: float

var power_required: int
var available_power_ratio: float



func update_stats():

	update_population()

	update_workers_ratio()

	update_required_power()
	update_power()
	update_power_ratio()

	update_pollution()
	
	update_production()
	update_research()

	SignalManager.island_stats_updated.emit(self)


func build(building: Building, tier: int, tile: Vector2i):
	world.spawn_building(building, tier, tile)
	buildings.append(tile)
	
	if building.is_town_center():
		definition.add_town_center_position(tile)

	update_stats()
	var los: int= building.get_los(tier)
	world.discover_los(tile, los)
	SignalManager.building_constructed.emit(tile)


func update_workers_ratio():
	max_workers= 0
	
	for building_pos in buildings:
		var building: Building= world.get_building(building_pos)
		if building.max_workers.is_empty(): continue
		max_workers+= building.max_workers[world.get_building_level(building_pos)]

	workers_ratio= clampf(population / float(max_workers), 0.0, 1.0)


func update_required_power():
	power_required= 0
	
	for building_pos in buildings:
		var building: Building= world.get_building(building_pos)
		power_required+= building.get_required_power(world.get_building_level(building_pos))


func update_pollution():
	pollution= 0
	for building_pos in buildings:
		pollution+= world.get_building_stat(Building.Stat.POLLUTION, building_pos)

	pollution= get_empire_state().apply_modifiers(BaseEmpireModifierEffect.Type.POLLUTION, pollution)


func update_population():
	population= 0
	for building_pos in buildings:
		population+= world.get_building_stat(Building.Stat.POPULATION, building_pos)

	population= get_empire_state().apply_modifiers(BaseEmpireModifierEffect.Type.POPULATION, population)


func update_production():
	base_production= 0
	for building_pos in buildings:
		base_production+= world.get_building_stat(Building.Stat.PRODUCTION, building_pos, available_power_ratio)

	base_production= get_empire_state().apply_modifiers(BaseEmpireModifierEffect.Type.PRODUCTION, base_production)
	production= floor(base_production * workers_ratio)


func update_power():
	power= 0
	for building_pos in buildings:
		power+= world.get_building_stat(Building.Stat.POWER, building_pos)

	power= get_empire_state().apply_modifiers(BaseEmpireModifierEffect.Type.POWER, power)


func update_power_ratio():
	available_power_ratio= clampf(float(power) / power_required, 0.0, 1.0)


func update_research():
	research= 0
	for building_pos in buildings:
		research+= world.get_building_stat(Building.Stat.RESEARCH, building_pos)

	research= get_empire_state().apply_modifiers(BaseEmpireModifierEffect.Type.RESEARCH, research)


func is_in_town_center_radius(tile: Vector2i)-> bool:
	for town_center_pos in definition.town_center_positions:
		if tile.distance_to(town_center_pos) <= world.get_town_center_radius(town_center_pos):
			return true
	return false


func get_empire_state()-> EmpireState:
	return GameData.get_empire_state()
