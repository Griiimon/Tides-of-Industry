class_name BaseUnitAction
extends NamedResource

@export var ap_cost: int= 1



func execute(unit: UnitInstance)-> bool:
	if unit.action_points_left < 0: 
		return true
	unit.action_points_left-= ap_cost
	if unit.action_points_left == 0:
		unit.kill()
		return false
	return true


func can_execute(unit: UnitInstance)-> bool:
	return true
