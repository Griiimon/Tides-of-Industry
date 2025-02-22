class_name Island
extends Resource

static var ID_CTR: int

@export var name: String
@export var town_center_positions: Array[Vector2i]
# TODO expand when town center levels up
@export var bounding_box: Rect2i



func _init(generate_name: bool= false):
	ID_CTR+= 1
	if generate_name:
		name= str("Island #", ID_CTR)


func add_town_center_position(tile: Vector2i):
	town_center_positions.append(tile)

	var default_size: int= 20
	if bounding_box.size == Vector2i.ZERO:
		bounding_box.position= tile - Vector2i.ONE * default_size / 2
		bounding_box.size= Vector2i.ONE * default_size
	else:
		bounding_box.expand(tile - Vector2i.ONE * default_size / 2)
		bounding_box.expand(tile + Vector2i.ONE * default_size / 2)
