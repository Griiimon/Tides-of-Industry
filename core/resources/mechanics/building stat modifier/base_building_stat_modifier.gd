class_name BaseBuildingStatModifier
extends Resource

var type: Building.Stat
var cached_value= 0



func update(tile: Vector2i, world: World, island: IslandInstance):
	assert(false, "Abstract class")


func apply(base_value: int)-> int:
	assert(false, "Abstract class")
	return 0
