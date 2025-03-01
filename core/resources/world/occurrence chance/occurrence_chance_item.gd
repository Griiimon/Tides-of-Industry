class_name OccurrenceChanceItem
extends Resource

@export var chance: float= 100.0



func evaluate(pos: Vector2i, _terrain: Terrain, _feature: TerrainFeature)-> float:
	return chance
