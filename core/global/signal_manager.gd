extends Node

signal show_tile_info(tile: Vector2)
signal hide_tile_info
signal camera_moved
signal island_stats_updated(island: IslandInstance)
signal empire_stats_updated

signal production_yields_changed(type: int, delta: int)
signal production_yields_updated(yields: ProductionYields)

signal start_research(technology: Technology)
signal no_research_selected

signal player_unit_moved(unit: UnitInstance)
signal player_unit_move_finished(unit: UnitInstance)
