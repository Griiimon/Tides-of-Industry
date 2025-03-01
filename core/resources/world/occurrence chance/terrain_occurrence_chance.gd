class_name TerrainOccurrenceChance
extends OccurrenceChanceItem

@export var terrain: Terrain



func evaluate(pos: Vector2i, _terrain: Terrain, feature: TerrainFeature)-> float:
	if terrain == _terrain:
		return super(pos, terrain, feature)
	return 0
