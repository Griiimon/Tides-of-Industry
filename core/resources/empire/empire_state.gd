class_name EmpireState
extends Resource

@export var money: float= 100
@export var construction_points: float= 250
@export var stability: float= 80

@export var production_yields: ProductionYields= ProductionYields.new()

@export var current_research: TechnologyLevel
@export var research_progress: float

@export var unlocked_technologies: Array[TechnologyLevel]



func has_technology_level(tech_level: TechnologyLevel)-> bool:
	for unlocked in unlocked_technologies:
		if unlocked.is_at_least(tech_level):
			return true
	return false


func research_finished():
	for unlocked in unlocked_technologies:
		if unlocked.technology == current_research.technology:
			unlocked.level+= 1
			return
	unlocked_technologies.append(current_research)


func can_afford(cost: int)-> bool:
	return money >= cost


func pay(amount: int):
	money-= amount
