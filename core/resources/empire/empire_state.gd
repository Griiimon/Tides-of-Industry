class_name EmpireState
extends Resource

@export_storage var money: float= 100
@export_storage var construction_points: float= 1000
@export_storage var stability: float= 80

@export_storage var production_yields: ProductionYields= ProductionYields.new()

@export_storage var current_research: TechnologyLevel
@export_storage var research_progress: float
@export_storage var unlocked_technologies: Array[TechnologyLevel]
@export_storage var unlocked_buildings: Array[BuildingTier]

@export_storage var active_modifiers: Array[ActiveEmpireModifierEffect]



func has_technology_level(tech_level: TechnologyLevel)-> bool:
	for unlocked in unlocked_technologies:
		if unlocked.is_at_least(tech_level):
			return true
	return false


func start_research(technology: Technology):
	current_research= TechnologyLevel.new(technology, get_technology_level(technology) + 1)
	SignalManager.start_research.emit(technology)


func research_finished(research: TechnologyLevel):
	var has_technology: bool= false
	for unlocked in unlocked_technologies:
		if unlocked.technology == research.technology:
			unlocked.level+= 1
			has_technology= true
			break

	if not has_technology:
		unlocked_technologies.append(research.duplicate())
			

	for unlocked in research.technology.unlocks_buildings[research.level].building_tiers:
		unlock_building(unlocked)
	
	for modifier_collection in research.technology.passive_modifiers:
		add_modifiers(modifier_collection)
	
	unlocked_technologies.append(research)
	SignalManager.technology_researched.emit(research)


func add_modifier(modifier: BaseEmpireModifierEffect):
	active_modifiers.append(modifier)


func add_modifiers(collection: EmpireModifierEffectCollection):
	for modifier in collection.effects:
		add_modifier(modifier)


func apply_modifiers(type: BaseEmpireModifierEffect.Type, base_value: int)-> int:
	var final_value: int= base_value
	for modifier in active_modifiers:
		final_value= modifier.apply_type(type, final_value)
	return final_value


func pay(amount: int):
	money-= amount


func spend_construction_points(cost: int):
	construction_points-= cost


func unlock_building(building_tier: BuildingTier):
	for unlocked in unlocked_buildings:
		if unlocked.building == building_tier.building:
			unlocked.tier= max(unlocked.tier, building_tier.tier)
			return
	unlocked_buildings.append(building_tier)


func can_afford(cost: int)-> bool:
	return money >= cost


func has_construction_points(cost: int)-> bool:
	return construction_points >= cost


func is_building_unlocked(building_tier: BuildingTier)-> bool:
	for unlocked in unlocked_buildings:
		if unlocked.is_at_least(building_tier):
			return true
	return false


func get_technology_level(technology: Technology)-> int:
	for tech_level in unlocked_technologies:
		if tech_level.technology == technology:
			return tech_level.level
	return 0


func get_research_cost()-> int:
	return current_research.technology.costs[current_research.level]


func get_research_progress_ratio()-> float:
	if not current_research: return 0.0
	return float(research_progress) / get_research_cost()
