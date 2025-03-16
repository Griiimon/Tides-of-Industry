class_name TownCenterRadiusPlacementCondition
extends BaseBuildingPlacementCondition

@export var invert: bool= false



func evaluate(tile: Vector2i, building: Building, world: World, city: CityInstance)-> bool:
	if not city:
		return invert
	
	return (not invert) == city.is_in_town_center_radius(tile)
