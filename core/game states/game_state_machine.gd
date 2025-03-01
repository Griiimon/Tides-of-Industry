class_name GameStateMachine
extends FiniteStateMachine

@export var world: World
@export var camera: MyCamera

@onready var game: Game= get_parent()
@onready var idle_state: GameStateIdle = $Idle
@onready var construction_state: GameStateConstruction = $Construction
@onready var move_unit_state: GameStateMoveUnit = $"Move Unit"



func _ready() -> void:
	idle_state.start_construction.connect(change_state.bind(construction_state))
	idle_state.unit_selected.connect(select_unit)
	
	construction_state.finished.connect(change_state.bind(idle_state))

	move_unit_state.other_unit_selected.connect(select_unit)
	move_unit_state.finished.connect(change_state.bind(idle_state))


func build(building: Building):
	construction_state.building= building
	change_state(construction_state)


func select_unit(unit: UnitInstance):
	move_unit_state.unit= unit
	change_state(move_unit_state)


func reset():
	change_state(idle_state)
