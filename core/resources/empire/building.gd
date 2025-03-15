class_name Building
extends NamedResource

enum Stat { POPULATION, PRODUCTION, POLLUTION, POWER, RESEARCH }

const DEFAULT_LOS= 5

@export var atlas_coords: Array[Vector2i]
@export var build_costs: Array[int]
@export var available_in_build_menu: bool= true
@export var can_destroy_neighbor_features: bool= true
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
@export var power_required: Array[int]

@export var custom_los: Array[int]
@export var extract_raw_materials: Array[RawMaterial]



func evaluate_placement_conditions(tile: Vector2i, world: World, island: IslandInstance)-> bool:
	for condition in placement_conditions:
		if not condition.evaluate(tile, self, world, island):
			return false
	return true


func get_stat(stat: Stat, tier: int, tile: Vector2i, world: World, island: IslandInstance, temp_log: bool= false)-> int:
	var result: int= get_base_stat(stat, tier)

	world.clear_building_stat(tile, stat, temp_log)
	if result != 0:
		world.log_building_stat(tile, stat, "Base", result, temp_log) 

	for modifier in stat_modifiers:
		assert(modifier.get_stat() > -1)
		if modifier.get_stat() == stat:
			if DebugSettings.is_enabled() and Input.is_action_pressed("debug_building_stats"):
				breakpoint

			var modifier_result= modifier.apply(result, self, tile, tier, world, island)
			if result > 0:
				modifier_result= max(0, modifier_result)
			elif result < 0:
				modifier_result= min(0, modifier_result)

			var delta: int= modifier_result - result
			if delta != 0:
				world.log_building_stat(tile, stat, modifier.get_short_desc(), delta, temp_log) 
				
			result= modifier_result
	return result


func get_base_stat(stat: Stat, tier: int)-> int:
	match stat:
		Stat.POPULATION:
			return population[tier] if tier < population.size() else 0
		Stat.PRODUCTION:
			return production[tier] if tier < production.size() else 0
		Stat.POWER:
			return power[tier] if tier < power.size() else 0
		Stat.POLLUTION:
			return pollution[tier] if tier < pollution.size() else 0
		Stat.RESEARCH:
			return research[tier] if tier < research.size() else 0
	assert(false, str(stat, " ", tier))
	return 0


func update_stats(tier: int, tile: Vector2i, world: World, island: IslandInstance):
	for stat in Stat.values():
		get_stat(stat, tier, tile, world, island, true)


func can_extract(raw_material: RawMaterial)-> bool:
	return raw_material in extract_raw_materials


func get_required_power(tier: int)-> int:
	if power_required.is_empty():
		return 0
	return power_required[min(tier, power_required.size() - 1)]


func does_require_power()-> bool:
	return not power_required.is_empty()


func get_cost(level: int)-> int:
	return build_costs[level]


func get_max_level()-> int:
	return build_costs.size() - 1


func can_upgrade_from(tier: int):
	return tier < get_max_level()
 

func get_upgrade_cost(tier: int):
	return build_costs[tier + 1]


func get_los(tier: int)-> int:
	if custom_los.is_empty():
		return DEFAULT_LOS
	return custom_los[min(tier, custom_los.size() - 1)]


func is_town_center()-> bool:
	return false
