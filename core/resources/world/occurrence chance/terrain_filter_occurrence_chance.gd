class_name TerrainFilterOccurrenceChance
extends OccurrenceChanceItem

@export var terrain_whitelist: Array[Terrain]
@export var terrain_blacklist: Array[Terrain]



func evaluate(pos: Vector2i, terrain: Terrain)-> float:
	if not terrain_whitelist.is_empty() and not terrain in terrain_whitelist:
		return 0
	if not terrain_blacklist.is_empty() and terrain in terrain_blacklist:
		return 0

	return super(pos, terrain)
