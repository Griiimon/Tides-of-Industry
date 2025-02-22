class_name BuildingStatPercentageModifier
extends BaseBuildingStatModifier

@export var percentage: float



func update(tile: Vector2i, world: World, island: IslandInstance):
	cached_value= (1 + percentage) * sign(percentage)


func update_n_times(n: int):
	cached_value= (1 + percentage * n) * sign(percentage)


func apply(base_value: int)-> int:
	return base_value * cached_value
