class_name PoliticalView
extends NamedResource

@export var min_require_pop: int
@export var pop_cap: int



func has_pop_cap()-> bool:
	return pop_cap > 0
