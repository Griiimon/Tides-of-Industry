class_name ReformismPolicy
extends BasePolicy



func get_modifier(modifier: Modifier)-> Variant:
	match modifier:
		Modifier.STABILITY_PENALTY:
			return level * 0.1
		Modifier.PROGRESSION_BONUS_POINTS:
			return level * 0.01
	return super(modifier)
