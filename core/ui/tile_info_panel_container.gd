class_name TileInfoPanelContainer
extends PanelContainer

@onready var building_label: Label = %"Building Label"
@onready var terrain_label: Label = %"Terrain Label"
@onready var feature_label: Label = %"Feature Label"
@onready var unit_label: Label = %"Unit Label"
@onready var unit_moves_label: Label = %"Unit Moves Label"



func update(building: Building, terrain: Terrain, feature: TerrainFeature, unit: UnitInstance):
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

	if unit:
		unit_label.text= unit.type.get_display_name()
		unit_moves_label.text= str(unit.moves_left, " move(s)")
		unit_label.show()
		unit_moves_label.show()
	else:
		unit_label.hide()
		unit_moves_label.hide()
