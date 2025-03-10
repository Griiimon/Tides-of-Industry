class_name EventNewResearch
extends BaseEvent

var research: TechnologyLevel
var progress_ratio: float= 0.5



func generate(rng: RandomNumberGenerator):
	var list: Array[Technology]
	for technology in GameData.technologies:
		if not get_empire_state().is_researching(technology) and get_empire_state().can_research(technology):
			list.append(technology)
	
	var picked_technology: Technology= RngUtils.pick_random_rng(list, rng)
	research= TechnologyLevel.new(picked_technology, get_empire_state().get_technology_level(picked_technology) + 1)


func execute(rng: RandomNumberGenerator):
	get_empire_state().start_research(research.technology)
	get_empire_state().advance_research_to_ratio(progress_ratio)


func get_description()-> String:
	return str(description, " ", research.get_as_string())


func pre_condition()-> bool:
	return get_empire_state().has_available_research()


func get_chance()-> float:
	return chance * ( 1 + get_empire_state().get_policy_modifier(BasePolicy.Modifier.RESEARCH_EVENT_CHANCE) )
