class_name Terrain
extends NamedResource

@export var terrain_set_name: String
@export var is_sea: bool= false
@export var move_cost: int= 1
@export var base_production: int= 0

@export var terraforming_result: Terrain
@export var terraforming_cost: int= 0

@export var can_prospect: bool= false
