class_name UnitActionMove
extends BaseUnitAction

#var target_pos: Vector2i



#func _init(_target_pos: Vector2i):
	#target_pos= _target_pos


func execute(unit: UnitInstance):
	if unit.type.moves_cost_ap and unit.action_points_left > 0:
		unit.action_points_left-= 1
		if unit.action_points_left == 0:
			unit.kill()
