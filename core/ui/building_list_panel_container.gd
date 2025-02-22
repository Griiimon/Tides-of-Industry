class_name BuildingListPanelContainer
extends PanelContainer

signal selected(building: Building)

@onready var content: VBoxContainer = %"Content VBoxContainer"



func _ready() -> void:
	populate()


func populate():
	UIUtils.free_children(content)
	
	for building in GameData.buildings:
		UIUtils.add_button(content, building.get_display_name(), emit_signal.bind("selected", building))
