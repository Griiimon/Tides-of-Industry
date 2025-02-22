class_name UI
extends CanvasLayer

@export var world: World
@export var game_states: GameStateMachine

@export var tile_info_container_scene: PackedScene

@onready var action_bar_container: ActionBarPanelContainer = %"Action Bar PanelContainer"
@onready var building_list_container: BuildingListPanelContainer = %"Building List PanelContainer"


var tile_info_container: TileInfoPanelContainer



func _ready() -> void:
	assert(world)
	assert(tile_info_container_scene)

	action_bar_container.open_build_list.connect(building_list_container.show)
	action_bar_container.close_build_list.connect(building_list_container.hide)

	building_list_container.selected.connect(on_build)
	
	SignalManager.show_tile_info.connect(show_tile_info)
	SignalManager.hide_tile_info.connect(hide_tile_info)

	tile_info_container= tile_info_container_scene.instantiate()
	tile_info_container.hide()
	add_child(tile_info_container)


func show_tile_info(tile: Vector2i):
	tile_info_container.update(world.get_building(tile), world.get_terrain(tile), world.get_feature(tile))
	tile_info_container.position= get_viewport().get_mouse_position() + Vector2(20, 20)
	tile_info_container.show()


func hide_tile_info():
	tile_info_container.hide()


func on_build(building: Building):
	building_list_container.hide()
	action_bar_container.untoggle_build_button()
	game_states.build(building)
