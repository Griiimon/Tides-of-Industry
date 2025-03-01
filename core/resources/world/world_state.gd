class_name WorldState
extends Resource

@export var world_seed: String
@export var turns: int

@export var empire_state: EmpireState= EmpireState.new()



func get_seed_hash()-> int:
	return hash(world_seed)
