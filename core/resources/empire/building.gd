class_name Building
extends NamedResource

@export var atlas_coords: Vector2i
@export var build_costs: Array[int]
@export var category: BuildingCategory
@export var placement_conditions: Array[BaseBuildingPlacementCondition]

@export var production: Array[int]
@export var pollution: Array[int]
@export var population: Array[int]
@export var research: Array[int]



func evaluate_placement_conditions(tile: Vector2i, world: World, island: IslandInstance)-> bool:
	for condition in placement_conditions:
		if not condition.evaluate(tile, world, island):
			return false
	return true


func is_town_center()-> bool:
	return false
