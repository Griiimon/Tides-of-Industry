class_name Building
extends NamedResource

enum Stat { POPULATION, PRODUCTION, POLLUTION, POWER, RESEARCH }

@export var atlas_coords: Array[Vector2i]
@export var build_costs: Array[int]
@export var available_in_build_menu: bool= true
@export var category: BuildingCategory
@export var placement_conditions: Array[BaseBuildingPlacementCondition]
@export var stat_modifiers: Array[BaseBuildingStatModifier]
@export var empire_modifiers: Array[BaseEmpireModifierEffect]

@export var production: Array[int]
@export var pollution: Array[int]
@export var population: Array[int]
@export var power: Array[int]
@export var research: Array[int]
@export var max_workers: Array[int]



func evaluate_placement_conditions(tile: Vector2i, world: World, island: IslandInstance)-> bool:
	for condition in placement_conditions:
		if not condition.evaluate(tile, world, island):
			return false
	return true


func get_stat(stat: Stat, tier: int, tile: Vector2i, world: World, island: IslandInstance, temp_log: bool= false)-> int:
	var result: int
	match stat:
		Stat.POPULATION:
			result= population[tier] if tier < population.size() else 0
		Stat.PRODUCTION:
			result= production[tier] if tier < production.size() else 0
		Stat.POWER:
			result= power[tier] if tier < power.size() else 0
		Stat.POLLUTION:
			result= pollution[tier] if tier < pollution.size() else 0
		Stat.RESEARCH:
			result= research[tier] if tier < research.size() else 0

	world.clear_building_stat(tile, stat, temp_log)
	if result != 0:
		world.log_building_stat(tile, stat, "Base", result, temp_log) 

	for modifier in stat_modifiers:
		if modifier.type == stat:
			var modifier_result= modifier.apply(result, tile, tier, world, island)
			if result > 0:
				modifier_result= max(0, modifier_result)
			elif result < 0:
				modifier_result= min(0, modifier_result)

			var delta: int= modifier_result - result
			if delta != 0:
				world.log_building_stat(tile, stat, modifier.get_short_desc(), delta, temp_log) 
				
			result= modifier_result
	return result


func get_cost(level: int)-> int:
	return build_costs[level]


func get_max_level()-> int:
	return build_costs.size()


func can_upgrade_from(tier: int):
	return tier < get_max_level()
 

func get_upgrade_cost(tier: int):
	return build_costs[tier + 1]


func is_town_center()-> bool:
	return false
