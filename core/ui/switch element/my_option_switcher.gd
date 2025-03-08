class_name MyOptionSwitcher
extends MyBaseSwitcher


@export var options: Array[String]

var highlight: int= -1



func update_label():
	super()
	label.self_modulate= Color.YELLOW if index == highlight else Color.WHITE


func set_highlight(highlight_index: int):
	highlight= highlight_index
	update_label()


func get_range()-> int:
	return options.size()
