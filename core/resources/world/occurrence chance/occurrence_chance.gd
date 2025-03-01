class_name OccurrenceChance
extends Resource

@export var items: Array[OccurrenceChanceItem]



func evaluate(pos: Vector2i, terrain: Terrain)-> float:
	var current_chance: float= 1.0
	for item in items:
		var item_chance: float= item.evaluate(pos, terrain)
		current_chance*= item_chance / 100.0
		if is_zero_approx(current_chance):
			return 0
	return current_chance
