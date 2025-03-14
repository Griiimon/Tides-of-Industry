class_name UnitActionProspect
extends BaseUnitAction

@export var prospect_chance: float= 20.0



func execute(unit: UnitInstance)-> bool:
	if unit.world.has_undiscovered_raw_material(unit.tile_pos):
		if RngUtils.chance100_rng(prospect_chance, GameData.get_global_rng()):
			unit.world.discover_raw_material(unit.tile_pos)
	return super(unit)


func can_execute(unit: UnitInstance)-> bool:
	if not unit.get_terrain().can_prospect:
		return false
	if unit.world.get_raw_material(unit.tile_pos) != null:
		return false
	return true
