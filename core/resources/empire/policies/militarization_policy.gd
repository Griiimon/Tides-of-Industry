class_name MilitarizationPolicy
extends BasePolicy



func get_modifier(modifier: Modifier)-> Variant:
	match modifier:
		Modifier.GENERAL_CHANCE:
			return level * 0.1
	return super(modifier)
