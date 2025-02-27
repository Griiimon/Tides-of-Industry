class_name Unit
extends NamedResource

@export var atlas_coords: Vector2i
@export var is_ship: bool= false
@export var is_land_unit: bool= true
@export var moves_per_turn: int= 1



func can_enter_terrain(terrain: Terrain)-> bool:
	return (is_ship and terrain.is_sea) or (is_land_unit and not terrain.is_sea)
