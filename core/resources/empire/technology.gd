class_name Technology
extends NamedResource

@export var costs: Array[int]
@export var required_tech: TechnologyLevel

@export var passive_modifiers: Array[ModifierEffectCollection] 
@export var desc: String



func can_research(empire_state: EmpireState)-> bool:
	if not required_tech: return true
	return empire_state.has_technology_level(required_tech)


func get_current_level(empire_state: EmpireState)-> int:
	for tech_level in empire_state.unlocked_technologies:
		if tech_level.technology == self:
			return tech_level.level
	return -1


func get_max_level()-> int:
	return costs.size() - 1

func has_levels()-> bool:
	return costs.size() > 1
