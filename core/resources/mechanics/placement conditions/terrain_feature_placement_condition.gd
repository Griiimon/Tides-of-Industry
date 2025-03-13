class_name TerrainFeaturePlacementCondition
extends BaseBuildingPlacementCondition

@export var feature_whitelist: Array[TerrainFeature]
@export var feature_blacklist: Array[TerrainFeature]



func evaluate(tile: Vector2i, building: Building, world: World, island: IslandInstance)-> bool:
	var feature: TerrainFeature= world.get_feature(tile)
	
	if not feature_whitelist.is_empty() and not feature in feature_whitelist:
		#SignalManager.building_placement_warning.emit("Cannot build on " + World.get_terrain_name(terrain))
		return false
	
	if not feature_blacklist.is_empty() and feature in feature_blacklist:
		#SignalManager.building_placement_warning.emit("Cannot build on " + World.get_terrain_name(terrain))
		return false
	
	return true
