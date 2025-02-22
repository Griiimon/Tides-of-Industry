class_name Island
extends Resource

static var ID_CTR: int

@export var name: String
@export var town_center_positions: Array[Vector2i]



func _init(generate_name: bool= false):
	ID_CTR+= 1
	if generate_name:
		name= str("Island #", ID_CTR)
