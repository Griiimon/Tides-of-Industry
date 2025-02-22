class_name GameStateMachine
extends FiniteStateMachine

@export var world: World
@export var camera: MyCamera

@onready var idle_state: GameStateIdle = $Idle
@onready var construction_state: GameStateConstruction = $Construction



func _ready() -> void:
	idle_state.start_construction.connect(change_state.bind(construction_state))

	construction_state.finished.connect(change_state.bind(idle_state))


func build(building: Building):
	construction_state.building= building
	change_state(construction_state)
