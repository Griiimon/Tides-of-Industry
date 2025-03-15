class_name TileInfoPanelContainer
extends PanelContainer

@onready var building_label: Label = %"Building Label"
@onready var terrain_label: Label = %"Terrain Label"
@onready var feature_label: Label = %"Feature Label"
@onready var raw_material_label: Label = %"Raw Material Label"
@onready var production_label: Label = %"Production Label"
@onready var unit_label: Label = %"Unit Label"
@onready var unit_moves_label: Label = %"Unit Moves Label"
@onready var unit_ap_label: Label = %"Unit AP Label"
@onready var tile_coords_label: Label = %"Tile Coords Label"



func update(tile: Vector2i, building: Building, terrain: Terrain, feature: TerrainFeature, raw_material: RawMaterial, total_production: int, unit: UnitInstance):
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

	if raw_material:
		raw_material_label.text= raw_material.get_display_name()
		raw_material_label.show()
	else:
		raw_material_label.hide()

	production_label.text= str("Base Production: ", total_production)

	if unit:
		unit_label.text= unit.type.get_display_name()
		unit_moves_label.text= str(unit.moves_left, " move(s)")
		unit_ap_label.text= str(unit.action_points_left, "/", unit.type.action_points, " AP")
		unit_label.show()
		unit_moves_label.show()
		unit_ap_label.show()
	else:
		unit_label.hide()
		unit_moves_label.hide()
		unit_ap_label.hide()

	if DebugSettings.is_enabled():
		tile_coords_label.text= str(tile)
		tile_coords_label.show()
	else:
		tile_coords_label.hide()
