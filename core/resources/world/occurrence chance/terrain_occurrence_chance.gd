class_name TerrainOccurrenceChance
extends OccurrenceChanceItem

@export var terrain: Terrain



func evaluate(pos: Vector2i, _terrain: Terrain)-> float:
	if terrain == _terrain:
		return super(pos, terrain)
	return 0
