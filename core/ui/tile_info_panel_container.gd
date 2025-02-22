class_name TileInfoPanelContainer
extends PanelContainer

@onready var building_label: Label = %"Building Label"
@onready var terrain_label: Label = %"Terrain Label"
@onready var feature_label: Label = %"Feature Label"



func update(building: Building, terrain: Terrain, feature: TerrainFeature):
	if building:
		building_label.text= building.get_display_name()
		building_label.show()
	else:
		building_label.hide()
	
	if terrain:
		terrain_label.text= terrain.get_display_name()
	else:
		terrain_label.text= "Unknown"
	
	if feature:
		feature_label.text= feature.get_display_name()
		feature_label.show()
	else:
		feature_label.hide()
	
