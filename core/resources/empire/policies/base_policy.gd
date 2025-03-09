class_name BasePolicy
extends NamedResource

enum Modifier { EXPLORER_LOS_BONUS, MONEY_TO_STABILITY, RESEARCH_EVENT_CHANCE, RELIGIOUS_BUILDING_STABILITY_BONUS, FACTORY_PRODUCTION_BONUS, PROGRESSION_BONUS_POINTS, STABILITY_PENALTY, GENERAL_CHANCE, EXPLORER_CHANCE, ENGINEER_CHANCE, PROPHET_CHANCE }

@export var description: String
@export var cap_level: int= 0
@export_storage var level: int= 0



func get_modifier(modifier: Modifier)-> Variant:
	return get_base_modifier(modifier)


func get_base_modifier(modifier: Modifier)-> Variant:
	match modifier:
		Modifier.EXPLORER_LOS_BONUS:
			return 0
		Modifier.MONEY_TO_STABILITY:
			return 0.0
		Modifier.RESEARCH_EVENT_CHANCE:
			return 0.0
		Modifier.RELIGIOUS_BUILDING_STABILITY_BONUS:
			return 0.0
		Modifier.FACTORY_PRODUCTION_BONUS:
			return 0.0
		Modifier.PROGRESSION_BONUS_POINTS:
			return 0.0
		Modifier.STABILITY_PENALTY:
			return 0.0
		Modifier.GENERAL_CHANCE:
			return 0.0
		Modifier.EXPLORER_CHANCE:
			return 0.0
		Modifier.ENGINEER_CHANCE:
			return 0.0
		Modifier.PROPHET_CHANCE:
			return 0.0
	assert(false)
	return null


func get_explorer_bonus_los()-> int:
	return 0


func get_money_ratio_converted_to_stability()-> float:
	return 0.0


func get_research_event_chance()-> float:
	return 0.0


#func get_research_speed_bonus()-> float:
	#return 0.0


func get_religious_buildings_stability_bonus()-> float:
	return 0.0


func get_factory_productivity_bonus()-> float:
	return 0.0


func get_general_chance()-> float:
	return 0.0


func get_explorer_chance()-> float:
	return 0.0


func get_engineer_chance()-> float:
	return 0.0


func get_prophet_chance()-> float:
	return 0.0


func get_progression_points_bonus()-> float:
	return 0.0


func get_stability_penalty()-> float:
	return 0.0


func get_display_name()-> String:
	return super().trim_suffix("Policy")
