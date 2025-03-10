class_name TechnologyLevel
extends Resource

@export var technology: Technology
@export var level: int



func _init(_technology: Technology= null, _level: int= 0):
	technology= _technology
	level= _level


func is_at_least(tech_level: TechnologyLevel)-> bool:
	if technology != tech_level.technology: return false
	return level >= tech_level.level


func get_research_cost()-> int:
	return technology.costs[level]


func get_as_string()-> String:
	if not technology.has_levels():
		return technology.get_display_name()
	return "%s Lvl %d" % [ technology.get_display_name(), level + 1 ]
