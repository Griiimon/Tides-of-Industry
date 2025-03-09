class_name IndustrializationPolicy
extends BasePolicy



func get_modifier(modifier: Modifier)-> Variant:
	match modifier:
		Modifier.FACTORY_PRODUCTION_BONUS:
			return level * 0.1
		Modifier.ENGINEER_CHANCE:
			return level * 0.1
	return super(modifier)
