class_name EventManager
extends Resource

const BASE_EVENT_CHANCE= 1

@export var unlocked_events: Array[BaseEvent]

var rng: RandomNumberGenerator
var active_event: BaseEvent



func initialize(seed: int):
	SignalManager.closed_event_popup.connect.call_deferred(resolve_event)

	rng= RandomNumberGenerator.new()
	rng.seed= seed


func tick():
	if unlocked_events.is_empty(): return
	
	if RngUtils.chance100_rng(BASE_EVENT_CHANCE + unlocked_events.size(), rng):
		var event: BaseEvent
		for i in 10:
			event= RngUtils.pick_random_rng(unlocked_events, rng)
			if event.pre_condition():
				break
			else:
				event= null

		if not event: return
		
		if RngUtils.chance100_rng(event.get_chance(), rng):
			trigger_event.call_deferred(event)


func trigger_event(event: BaseEvent):
	active_event= event
	active_event.generate(rng)
	SignalManager.triggered_event.emit(event)


func resolve_event(default_option: bool):
	if not active_event.has_choice or not default_option:
		active_event.execute(rng)
	active_event= null


func add_event(event: BaseEvent):
	assert(not event in unlocked_events)
	unlocked_events.append(event)


func remove_event(event: BaseEvent):
	assert(event in unlocked_events)
	unlocked_events.erase(event)
