class_name EmpireState
extends Resource

@export var money: int
@export var construction_points: int
@export var stability: int

@export var current_research: Technology
@export var research_progress: int

@export var unlocked_technologies: Array[TechnologyLevel]



func has_technology_level(tech_level: TechnologyLevel)-> bool:
	for unlocked in unlocked_technologies:
		if unlocked.is_at_least(tech_level):
			return true
	return false
