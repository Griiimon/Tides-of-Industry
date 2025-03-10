class_name Empire

var units: Array[UnitInstance]
var last_used_unit: UnitInstance= null
var state: EmpireState



func _init():
	SignalManager.player_unit_move_finished.connect(on_unit_move_finished)
	state= GameData.get_empire_state()


func tick(world: World):
	
	var total_production: int
	
	for island in world.get_islands():
		total_production+= island.production
	
	var yields: ProductionYields= state.production_yields
	
	state.money+= yields.calculate(ProductionYields.Type.MONEY, total_production)
	state.construction_points+= yields.calculate(ProductionYields.Type.CONSTRUCTION_POINTS, total_production)

	if state.current_research: 
		state.research_progress+= yields.calculate(ProductionYields.Type.RESEARCH, total_production)
	
		if state.research_progress >= state.current_research.get_research_cost():
			state.research_finished(state.current_research)
			state.current_research= null
	else:
		SignalManager.no_research_selected.emit()

	for modifier in state.active_modifiers.duplicate():
		if modifier.lifetime > 0:
			modifier.lifetime-= 1
			if modifier.lifetime == 0:
				state.active_modifiers.erase(modifier)


	state.reform_points+= state.reform_points_increase

	SignalManager.empire_stats_updated.emit()


func on_unit_move_finished(unit: UnitInstance):
	last_used_unit= unit


func get_policy_modifier(modifier: BasePolicy.Modifier)-> Variant:
	return state.get_policy_modifier(modifier)


func has_moves_left()-> bool:
	for unit in units:
		if unit.has_moves_left():
			return true
	return false
