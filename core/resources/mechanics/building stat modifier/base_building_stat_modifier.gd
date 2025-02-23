class_name BaseBuildingStatModifier
extends Resource

@export var type: Building.Stat



func apply(base_value: int, tile: Vector2i, world: World, island: IslandInstance)-> int:
	assert(false, "Abstract class")
	return 0
