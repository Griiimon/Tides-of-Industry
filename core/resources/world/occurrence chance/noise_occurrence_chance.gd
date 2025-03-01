class_name NoiseOccurrenceChance
extends OccurrenceChanceItem

@export var noise: FastNoiseLite
@export var threshold: float
@export var analog: bool= false



func evaluate(pos: Vector2i, terrain: Terrain)-> float:
	var val: float= noise.get_noise_2dv(pos)

	if not analog:
		if val >= threshold:
			return super(pos, terrain)
		return 0

	if val < threshold:
		return 0
	return remap(val, threshold, 1, 0, 100)
