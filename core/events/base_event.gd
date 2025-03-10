class_name BaseEvent
extends Resource

@export var title: String
@export_multiline var description: String
@export var chance: float
@export var has_choice: bool= false
@export var confirm_cancel_button: String= "OK"
@export var option_button: String= ""



func pre_condition()-> bool:
	return true


func get_chance()-> float:
	return chance


func generate(rng: RandomNumberGenerator):
	pass


func execute(rng: RandomNumberGenerator):
	pass


func get_description()-> String:
	return description


static func get_empire_state()-> EmpireState:
	return GameData.get_empire_state()
