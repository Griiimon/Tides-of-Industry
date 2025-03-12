class_name SpecializationPolicy
extends BasePolicy



func get_modifier(modifier: Modifier)-> Variant:
	match modifier:
		Modifier.SPECIALIZATION_BONUS_PCT:
			return level * 0.01
	return super(modifier)
