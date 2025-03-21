extends Node

signal world_state_initialized

signal show_tile_info(tile: Vector2)
signal hide_tile_info
signal camera_moved
signal city_stats_updated(city: CityInstance)
signal empire_stats_updated

signal production_yields_changed(type: int, delta: int)
signal production_yields_updated(yields: ProductionYields)

signal start_research(technology: Technology)
signal technology_researched(technology: Technology)
signal no_research_selected
signal advance_research_to_ratio(ratio: float)
signal updated_research_progress()

signal player_unit_selected(unit: UnitInstance)
signal player_unit_deselected(unit: UnitInstance)
signal player_unit_moved(unit: UnitInstance)
signal player_unit_move_finished(unit: UnitInstance)
signal player_unit_killed(unit: UnitInstance)
signal unit_removed(unit: UnitInstance)
signal player_unit_action_executed(unit: UnitInstance)
signal update_unit_available_actions(unit: UnitInstance)

signal building_constructed(tile: Vector2i)
signal building_upgraded(tile: Vector2i)
signal display_building_log(building_log: BuildingLog)
signal display_construction_info(info: ConstructionInfo)
signal hide_building_panel

signal world_ticked

signal triggered_event(event: BaseEvent)
signal closed_event_popup(default_option: bool)

signal force_pause
signal cancel_forced_pause
