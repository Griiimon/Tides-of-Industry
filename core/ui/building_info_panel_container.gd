class_name BuildingInfoPanelContainer
extends PanelContainer

@onready var content: GridContainer = %"Content GridContainer"



func _ready() -> void:
	SignalManager.display_building_log.connect(populate_from_log)


func populate_from_log(building_log: BuildingLog):
	UIUtils.free_children(content)
	
	for i in building_log.get_total_entries():
		UIUtils.add_label(content, building_log.get_label(i), Color.BLACK)
		UIUtils.add_label(content, building_log.get_value(i), Color.BLACK)
