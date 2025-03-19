class_name Empire

var units: Array[UnitInstance]
var last_used_unit: UnitInstance= null
var state: EmpireState



func _init():
	SignalManager.player_unit_move_finished.connect(on_unit_move_finished)
	state= GameData.get_empire_state()


func tick(world: World):
	
	var total_production: int
	
	for city in world.get_cities():
		total_production+= city.production
	
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
	
	state.specialist_points_increase= world.get_population() * ( 0.1 + state.get_policy_modifier(BasePolicy.Modifier.SPECIALIZATION_BONUS_PCT))
	state.specialist_points+= state.specialist_points_increase
	if state.specialist_points >= state.specialist_points_required:
		spawn_random_specialist(world)
		state.specialist_points-= state.specialist_points_required
		state.specialist_points_required*= 2

	SignalManager.empire_stats_updated.emit()


func spawn_random_specialist(world: World):
	var chances: Dictionary
	chances[Unit.Specialist.EXPLORER]= state.get_policy_modifier(BasePolicy.Modifier.EXPLORER_CHANCE)
	chances[Unit.Specialist.GENERAL]= state.get_policy_modifier(BasePolicy.Modifier.GENERAL_CHANCE)
	chances[Unit.Specialist.PROPHET]= state.get_policy_modifier(BasePolicy.Modifier.PROPHET_CHANCE)
	chances[Unit.Specialist.ENGINEER]= state.get_policy_modifier(BasePolicy.Modifier.ENGINEER_CHANCE)

	var base_chance: float= 0.1
	var total_chance: float= 0.0
	for key in chances.keys():
		chances[key]+= base_chance
		total_chance+= chances[key]
	
	for key in chances.keys():
		chances[key]/= total_chance
	
	var last_key= null
	for key in chances.keys():
		if last_key:
			chances[key]+= chances[last_key]
		last_key= key

	var rnd: float= world.rng.randf()

	var specialist_unit: Unit
	for key in chances.keys():
		if rnd < chances[key]:
			specialist_unit= GameData.specialist_unit_lookup[key]
	
	var spawn_pos: Vector2i= world.get_cities()[0].definition.town_center_positions[0]
	world.spawn_unit(specialist_unit, spawn_pos)


func on_unit_move_finished(unit: UnitInstance):
	last_used_unit= unit


func get_policy_modifier(modifier: BasePolicy.Modifier)-> Variant:
	return state.get_policy_modifier(modifier)


func has_moves_left()-> bool:
	for unit in units:
		if unit.has_moves_left():
			return true
	return false
