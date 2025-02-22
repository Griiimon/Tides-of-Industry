class_name TerrainPlacementCondition
extends BaseBuildingPlacementCondition

@export var terrain_whitelist: Array[Terrain]
@export var terrain_blacklist: Array[Terrain]



func evaluate(tile: Vector2i, world: World, island: IslandInstance)-> bool:
	var terrain: Terrain= world.get_terrain(tile)
	
	if not terrain_whitelist.is_empty() and not terrain in terrain_whitelist:
		#SignalManager.building_placement_warning.emit("Cannot build on " + World.get_terrain_name(terrain))
		return false
	
	if not terrain_blacklist.is_empty() and terrain in terrain_blacklist:
		#SignalManager.building_placement_warning.emit("Cannot build on " + World.get_terrain_name(terrain))
		return false
	
	return true
