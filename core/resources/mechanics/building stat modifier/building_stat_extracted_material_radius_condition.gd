class_name BuildingExtractedMaterialRadiusCondition
extends BaseBuildingStatConditionalModifier

@export var raw_material: RawMaterial
@export var radius: int



func is_condition_met(tile: Vector2i, world: World, island: IslandInstance)-> bool:
	for worked_tile in world.get_tiles_in_radius(tile, radius, false):
		var building: Building= world.get_building(worked_tile)
		if building:
			if world.get_raw_material(worked_tile) == raw_material:
				if building.can_extract(raw_material):
					return true
	return false


func get_short_desc()-> String:
	return str("Access to ", raw_material.get_display_name())
