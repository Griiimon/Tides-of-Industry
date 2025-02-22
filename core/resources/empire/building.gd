class_name Building
extends NamedResource

enum Stat { POPULATION, PRODUCTION, POLLUTION, POWER, RESEARCH }

@export var atlas_coords: Vector2i
@export var build_costs: Array[int]
@export var category: BuildingCategory
@export var placement_conditions: Array[BaseBuildingPlacementCondition]
@export var stat_modifiers: Array[BaseBuildingStatModifier]

@export var production: Array[int]
@export var pollution: Array[int]
@export var population: Array[int]
@export var power: Array[int]
@export var research: Array[int]



func evaluate_placement_conditions(tile: Vector2i, world: World, island: IslandInstance)-> bool:
	for condition in placement_conditions:
		if not condition.evaluate(tile, world, island):
			return false
	return true


func get_stat(stat: Stat, level: int)-> int:
	var result: int
	match stat:
		Stat.POPULATION:
			result= population[level] if level <= population.size() else 0
		Stat.PRODUCTION:
			result= production[level] if level <= production.size() else 0
		Stat.POWER:
			result= power[level] if level <= power.size() else 0
		Stat.POLLUTION:
			result= pollution[level] if level <= pollution.size() else 0
		Stat.RESEARCH:
			result= research[level] if level <= research.size() else 0

	for modifier in stat_modifiers:
		result= modifier.apply(result)
	
	return result


func is_town_center()-> bool:
	return false
