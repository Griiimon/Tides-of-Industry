class_name ExpansionPolicy
extends BasePolicy



func get_modifier(modifier: Modifier)-> Variant:
	match modifier:
		Modifier.EXPLORER_LOS_BONUS:
			return level
		Modifier.EXPLORER_CHANCE:
			return level * 0.1
	return super(modifier)
