class_name BaseBuildingStatModifierWithStat
extends BaseBuildingStatModifier

@export var type: Building.Stat



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	assert(false, "Abstract class")
	return 0


func get_stat()-> Building.Stat:
	return type
