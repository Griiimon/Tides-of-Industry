class_name BaseBuildingStatConditionalModifier
extends BaseBuildingStatModifier

@export var modifier: BaseBuildingStatModifier



func apply(base_value: int, tile: Vector2i, world: World, island: IslandInstance)-> int:
	if is_condition_met(tile, world, island):
		return modifier.apply(base_value, tile, world, island)
	return 0


func is_condition_met(tile: Vector2i, world: World, island: IslandInstance)-> bool:
	return false
