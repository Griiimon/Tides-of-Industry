class_name WorldState
extends Resource

@export var world_seed: String
@export var turns: int

@export var empire_state: EmpireState= EmpireState.new()
@export var event_manager: EventManager= EventManager.new()



func initialize():
	event_manager.initialize(get_seed_hash())
	
	for event in GameData.initial_events:
		event_manager.add_event(event)
	
	empire_state.initialize()


func get_seed_hash()-> int:
	return hash(world_seed)
