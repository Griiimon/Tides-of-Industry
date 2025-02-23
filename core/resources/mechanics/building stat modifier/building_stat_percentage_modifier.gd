class_name BuildingStatPercentageModifier
extends BaseBuildingStatModifier

@export var percentage: float



func apply(base_value: int, tile: Vector2i, world: World, island: IslandInstance)-> int:
	return base_value * (1 + percentage / 100.0)


func apply_n_times(n: int, base_value: int, tile: Vector2i, world: World, island: IslandInstance)-> int:
	if n == 0: return base_value
	return base_value * (1 + percentage / 100.0 * n)
