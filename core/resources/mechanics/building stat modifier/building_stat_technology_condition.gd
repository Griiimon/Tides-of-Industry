class_name BuildingStatTechnologyCondition
extends BaseBuildingStatConditionalModifier

@export var technology_level: TechnologyLevel



func is_condition_met(tile: Vector2i, world: World, city: CityInstance)-> bool:
	return GameData.get_empire_state().has_technology_level(technology_level)
