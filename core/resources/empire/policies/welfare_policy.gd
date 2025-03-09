class_name WelfarePolicy
extends BasePolicy



func get_modifier(modifier: Modifier)-> Variant:
	match modifier:
		Modifier.MONEY_TO_STABILITY:
			return level * 0.1
	return super(modifier)
