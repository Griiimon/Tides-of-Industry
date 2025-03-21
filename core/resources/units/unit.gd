class_name Unit
extends NamedResource

enum Specialist { NONE= -1, EXPLORER, ENGINEER, GENERAL, PROPHET }

@export var atlas_coords: Vector2i
@export var specialist: Specialist= Specialist.NONE
@export var is_ship: bool= false
@export var is_land_unit: bool= true
@export var moves_per_turn: int= 1
@export var action_points: int= 100
@export var moves_cost_ap: bool= false

@export var available_actions: Array[BaseUnitAction]



func can_enter_terrain(terrain: Terrain)-> bool:
	return (is_ship and terrain.is_sea) or (is_land_unit and not terrain.is_sea)


func get_los()-> int:
	return 2
