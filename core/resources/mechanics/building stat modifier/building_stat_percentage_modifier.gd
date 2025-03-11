class_name BuildingStatPercentageModifier
extends BaseBuildingStatModifierWithStat

@export var percentage: float
@export var tier_factor: float= 1.0  



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	return base_value * (1 + percentage * ( 1 + building_tier * tier_factor ) / 100.0)


func apply_n_times(n: int, base_value: int, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	if n == 0: return base_value
	return base_value * (1 + percentage * ( 1 + building_tier * tier_factor ) / 100.0 * n)
