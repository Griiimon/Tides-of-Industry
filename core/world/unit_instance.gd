class_name UnitInstance
extends Resource

@export_storage var type: Unit
var world: World

@export_storage var is_ai: bool
@export_storage var tile_pos: Vector2i
@export_storage var moves_left: int
@export_storage var amphibious_state_ship: bool= false



func _init(_type: Unit= null, _tile_pos: Vector2i= Vector2i.ZERO, player_unit: bool= true, _world: World= null) -> void:
	if not _type: return
	type= _type
	tile_pos= _tile_pos
	is_ai= not player_unit
	world= _world
	moves_left= get_actual_type().moves_per_turn


func move_to(new_tile_pos: Vector2i):
	world.update_unit_pos(self, new_tile_pos, tile_pos, true)
	tile_pos= new_tile_pos
	assert(moves_left > 0)
	moves_left-= 1


func can_move_to(new_tile_pos: Vector2i):
	if world.is_tile_occupied(new_tile_pos):
		return false
	
	var terrain: Terrain= world.get_terrain(new_tile_pos)
	if not can_enter_terrain(terrain):
		return false
	
	#var feature: TerrainFeature= world.get_feature(new_tile_pos)
	return true


func move(dir: Vector2i):
	var new_tile_pos: Vector2i= tile_pos + dir
	move_to(new_tile_pos)


func reset_moves():
	moves_left= get_actual_type().moves_per_turn


func can_move(dir: Vector2i):
	var new_tile_pos: Vector2i= tile_pos + dir
	return can_move_to(new_tile_pos)


func can_enter_terrain(terrain: Terrain)-> bool:
	return get_actual_type().can_enter_terrain(terrain)


func get_atlas_coords()-> Vector2i:
	return get_actual_type().atlas_coords


func get_actual_type()-> Unit:
	if type is AmphibiousUnit:
		if world.get_terrain(tile_pos).is_sea:
				return (type as AmphibiousUnit).ship_reference
	return type


func has_moves_left()-> bool:
	return moves_left > 0
