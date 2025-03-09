class_name SpiritualityPolicy
extends BasePolicy



func get_modifier(modifier: Modifier)-> Variant:
	match modifier:
		Modifier.RELIGIOUS_BUILDING_STABILITY_BONUS:
			return level * 0.1
		Modifier.PROPHET_CHANCE:
			return level * 0.1
	return super(modifier)
