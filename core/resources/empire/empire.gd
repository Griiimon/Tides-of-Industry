class_name Empire

var units: Array[UnitInstance]



func tick(world: World):
	var state: EmpireState= GameData.get_empire_state()
	
	var total_production: int
	
	for island in world.get_islands():
		total_production+= island.production
	
	var yields: ProductionYields= state.production_yields
	
	state.money+= yields.calculate(ProductionYields.Type.MONEY, total_production)
	state.construction_points+= yields.calculate(ProductionYields.Type.CONSTRUCTION_POINTS, total_production)

	if state.current_research: 
		state.research_progress+= yields.calculate(ProductionYields.Type.RESEARCH, total_production)
	
		if state.research_progress >= state.current_research.get_research_cost():
			state.research_finished()
			state.current_research= null
	else:
		SignalManager.no_research_selected.emit()

	for modifier in state.active_modifiers.duplicate():
		if modifier.lifetime > 0:
			modifier.lifetime-= 1
			if modifier.lifetime == 0:
				state.active_modifiers.erase(modifier)


	SignalManager.empire_stats_updated.emit()
