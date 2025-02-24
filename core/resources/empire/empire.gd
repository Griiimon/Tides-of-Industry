class_name Empire



func tick(world: World):
	var state: EmpireState= GameData.get_empire_state()
	
	var total_production: int
	
	for island in world.get_islands():
		total_production+= island.production
	
	var yields: ProductionYields= state.production_yields
	
	state.money+= yields.calculate(ProductionYields.Type.MONEY, total_production)
	state.construction_points+= yields.calculate(ProductionYields.Type.CONSTRUCTION_POINTS, total_production)
	state.research_progress+= yields.calculate(ProductionYields.Type.RESEARCH, total_production)

	SignalManager.empire_stats_updated.emit()
