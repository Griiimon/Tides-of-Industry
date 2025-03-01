class_name OccurrenceChance
extends Resource

@export var items: Array[OccurrenceChanceItem]
@export var multiply: bool= true



func evaluate(pos: Vector2i, terrain: Terrain, feature: TerrainFeature)-> float:
	var current_chance: float= 1.0 if multiply else 0.0
	for item in items:
		var item_chance: float= item.evaluate(pos, terrain, feature)
		if multiply:
			current_chance*= item_chance / 100.0
			if is_zero_approx(current_chance):
				return 0
		else:
			current_chance= max(current_chance, item_chance / 100.0)
			 
	return current_chance
