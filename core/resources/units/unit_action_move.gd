class_name UnitActionMove
extends BaseUnitAction



func execute(unit: UnitInstance):
	if unit.type.moves_cost_ap:# and unit.action_points_left > 0:
		super(unit)
