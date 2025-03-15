class_name BaseBuildingStatConditionalModifier
extends BaseBuildingStatModifier

@export var modifier: BaseBuildingStatModifier
@export var inverted: bool= false



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	var condition: bool= is_condition_met(tile, world, island)
	if (condition and not inverted) or (not condition and inverted):
		return modifier.apply(base_value, building, tile, building_tier, world, island)
	return base_value


func get_stat()-> Building.Stat:
	return modifier.get_stat()


func is_condition_met(tile: Vector2i, world: World, island: IslandInstance)-> bool:
	return false


func get_short_desc()-> String:
	if inverted:
		return str("Not ", modifier.get_short_desc())
	return modifier.get_short_desc()
