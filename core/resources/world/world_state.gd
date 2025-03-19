class_name WorldState
extends Resource

@export_storage var world_seed: String
@export_storage var turns: int

@export_storage var empire_state: EmpireState= EmpireState.new()
@export_storage var event_manager: EventManager= EventManager.new()

var rng: RandomNumberGenerator



func initialize():
	event_manager.initialize(get_seed_hash())
	
	for event in GameData.initial_events:
		event_manager.add_event(event)
	

	rng= RandomNumberGenerator.new()
	rng.seed= get_seed_hash()

	SignalManager.world_state_initialized.emit()


func get_seed_hash()-> int:
	return hash(world_seed)
