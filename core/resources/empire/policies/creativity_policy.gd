class_name CreativityPolicy
extends BasePolicy



func get_modifier(modifier: Modifier)-> Variant:
	match modifier:
		Modifier.RESEARCH_EVENT_CHANCE:
			return level * 0.1
	return super(modifier)
