class_name BaseBuildingStatModifier
extends Resource



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	assert(false, "Abstract class")
	return 0


func get_short_desc()-> String:
	assert(false, "Abstract class")
	return ""
