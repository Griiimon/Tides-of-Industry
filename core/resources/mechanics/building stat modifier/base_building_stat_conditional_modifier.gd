class_name BaseBuildingStatConditionalModifier
extends BaseBuildingStatModifier

@export var modifier: BaseBuildingStatModifier



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	if is_condition_met(tile, world, island):
		return modifier.apply(base_value, building, tile, building_tier, world, island)
	return 0


func get_stat()-> Building.Stat:
	return modifier.get_stat()


func is_condition_met(tile: Vector2i, world: World, island: IslandInstance)-> bool:
	return false
