class_name BuildingCancelStatModifier
extends BaseBuildingStatModifierWithStat



func apply(base_value: int, building: Building, tile: Vector2i, building_tier: int, world: World, island: IslandInstance)-> int:
	return -base_value


func get_stat()-> Building.Stat:
	return type
