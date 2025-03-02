class_name BuildingListPanelContainer
extends PanelContainer

signal selected(building: Building, tier: int)

@onready var content: GridContainer = %"Content GridContainer"



func _ready() -> void:
	populate()


func populate():
	UIUtils.free_children(content)
	
	for building in GameData.buildings:
		var label: Label= UIUtils.add_label(content, building.get_display_name())

		for tier in 3:
			if tier < building.get_max_level():
				UIUtils.add_button(content, str("Tier ", tier + 1), on_build.bind(building, tier))
			else:
				UIUtils.add_empty(content)


func on_build(building: Building, tier: int):
	selected.emit(building, tier)
