class_name UI
extends CanvasLayer

const FLOATING_TILE_INFO_CONTAINER= false

@export var world: World
@export var game_states: GameStateMachine

@export var tile_info_container_scene: PackedScene

@onready var top_bar_container: TopBarPanelContainer = $"Top Bar PanelContainer"
@onready var action_bar_container: ActionBarPanelContainer = $"Action Bar PanelContainer"
@onready var unit_action_bar_container: UnitActionBarPanelContainer = $"Unit Action Bar PanelContainer"
@onready var building_list_container: BuildingListPanelContainer = $"Building List PanelContainer"
@onready var research_popup: ResearchPopupPanel = $"Research Popup"
@onready var production_yield_container: ProductionYieldPanelContainer = $"Production Yield PanelContainer"
@onready var policies_popup: PoliciesPopupPanel = $"Policies Popup"
@onready var event_popup: EventPopup = $"Event Popup"


@onready var tile_info_container: TileInfoPanelContainer = $"Tile Info PanelContainer"



func _ready() -> void:
	assert(world)
	assert(tile_info_container_scene)

	action_bar_container.open_build_list.connect(on_toggle_build_list.bind(true))
	action_bar_container.close_build_list.connect(on_toggle_build_list.bind(false))
	action_bar_container.open_research_list.connect(research_popup.open)
	action_bar_container.close_research_list.connect(research_popup.hide)
	action_bar_container.upgrade.connect(on_upgrade)
	action_bar_container.cancel_upgrade.connect(on_cancel_upgrade)
	action_bar_container.open_policies.connect(policies_popup.open)
	action_bar_container.close_policies.connect(policies_popup.hide)

	building_list_container.selected.connect(on_build)
	
	research_popup.request_close.connect(action_bar_container.untoggle_research_button)

	SignalManager.show_tile_info.connect(show_tile_info)
	SignalManager.hide_tile_info.connect(hide_tile_info)
	SignalManager.island_stats_updated.connect(on_island_stats_updated)
	SignalManager.empire_stats_updated.connect(update_top_bar)
	SignalManager.building_constructed.connect(on_building_constructed)
	SignalManager.building_upgraded.connect(on_building_constructed)
	SignalManager.player_unit_selected.connect(on_player_unit_selected)
	SignalManager.player_unit_deselected.connect(on_player_unit_deselected)
	SignalManager.triggered_event.connect(on_event_triggered)
	SignalManager.player_unit_action_executed.connect(on_player_unit_action_executed)

	if FLOATING_TILE_INFO_CONTAINER:
		tile_info_container.queue_free()
		tile_info_container= tile_info_container_scene.instantiate()
		tile_info_container.hide()
		add_child(tile_info_container)
	else:
		SignalManager.player_unit_moved.connect(on_player_unit_moved)

	update.call_deferred()


func update():
	update_top_bar()


func show_tile_info(tile: Vector2i):
	tile_info_container.update(world.get_building(tile), world.get_terrain(tile), world.get_feature(tile),\
			world.get_raw_material(tile), world.get_tile_base_production(tile), world.get_unit(tile))
	
	if FLOATING_TILE_INFO_CONTAINER:
		tile_info_container.position= get_viewport().get_mouse_position() + Vector2(20, 20)
	tile_info_container.show()


func hide_tile_info():
	if FLOATING_TILE_INFO_CONTAINER:
		tile_info_container.hide()


func update_top_bar():
	top_bar_container.update(get_island_in_view())


func on_build(building: Building, tier: int):
	building_list_container.hide()
	action_bar_container.untoggle_build_button()
	game_states.build(building, tier)


func on_upgrade():
	game_states.upgrade()


func on_cancel_upgrade():
	game_states.reset()


func on_island_stats_updated(island: IslandInstance):
	if get_island_in_view() == island:
		update_top_bar()


func on_player_unit_moved(unit: UnitInstance):
	show_tile_info(unit.tile_pos)


func on_toggle_build_list(b: bool):
	if b:
		building_list_container.show()
		production_yield_container.hide()
	else:
		building_list_container.hide()
		production_yield_container.show()


func on_building_constructed(tile: Vector2i):
	update_top_bar()


func on_player_unit_selected(unit: UnitInstance):
	action_bar_container.hide()
	unit_action_bar_container.show()
	unit_action_bar_container.activate(unit)


func on_player_unit_deselected(unit: UnitInstance):
	unit_action_bar_container.hide()
	action_bar_container.show()


func on_event_triggered(event: BaseEvent):
	event_popup.open(event)


func on_player_unit_action_executed(unit: UnitInstance):
	show_tile_info(unit.tile_pos)


func get_island_in_view()-> IslandInstance:
	var global_pos: Vector2= get_viewport().get_camera_2d().get_screen_center_position()
	return world.get_island(world.get_tile(global_pos))
