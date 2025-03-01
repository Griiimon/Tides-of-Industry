class_name TerrainFeatureOccurrenceChance
extends OccurrenceChanceItem

@export var feature: TerrainFeature



func evaluate(pos: Vector2i, _terrain: Terrain, _feature: TerrainFeature)-> float:
	if feature == _feature:
		return super(pos, _terrain, _feature)
	return 0
