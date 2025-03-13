class_name TownCenterRadiusPlacementCondition
extends BaseBuildingPlacementCondition

@export var invert: bool= false



func evaluate(tile: Vector2i, building: Building, world: World, island: IslandInstance)-> bool:
	if not island:
		return invert
	
	return (not invert) == island.is_in_town_center_radius(tile)
