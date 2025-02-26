class_name UnitInstance

var type: Unit
var world: World

var tile_pos: Vector2i
var moves_left: int



func _init(_type: Unit, _tile_pos: Vector2i, _world: World) -> void:
	type= _type
	tile_pos= _tile_pos
	world= _world


func move(dir: Vector2i):
	var new_tile_pos: Vector2i= tile_pos + dir
	world.move_unit(self, tile_pos, new_tile_pos)


func can_move(dir: Vector2i):
	var new_tile_pos: Vector2i= tile_pos + dir
	if world.is_tile_occupied(new_tile_pos):
		return false
	
	var terrain: Terrain= world.get_terrain(new_tile_pos)
	if not type.can_enter_terrain(terrain):
		return false
	
	var feature: TerrainFeature= world.get_feature(new_tile_pos)
	
