class_name BuildingInfoPanelContainer
extends PanelContainer

@onready var content: GridContainer = %"Content GridContainer"



func _ready() -> void:
	SignalManager.display_building_log.connect(populate_from_log)
	SignalManager.display_construction_info.connect(populate_from_construction_info)
	SignalManager.hide_building_panel.connect(hide)


func populate_from_log(building_log: BuildingLog, clear_panel: bool= true):
	if clear_panel:
		UIUtils.free_children(content)
	
	for i in building_log.get_total_entries():
		UIUtils.add_label(content, building_log.get_label(i), Color.BLACK)
		UIUtils.add_label(content, building_log.get_value(i), Color.BLACK)
	show()


func populate_from_construction_info(info: ConstructionInfo):
	UIUtils.free_children(content)

	UIUtils.add_labels(content, [info.building.get_display_name(), "",\
			"Tier ", str(info.building_tier + 1),\
			"Cost", str(info.cost),\
			"Valid Position", str(info.is_valid_position),\
			"---", "---"])
	populate_from_log(info.stats, false)
	show()
