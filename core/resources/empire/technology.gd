class_name Technology
extends NamedResource

@export var costs: Array[int]
@export var required_tech: TechnologyLevel

@export var passive_modifiers: Array[ModifierEffectCollection] 



func can_research(empire_state: EmpireState)-> bool:
	if not required_tech: return true
	return empire_state.has_technology_level(required_tech)
