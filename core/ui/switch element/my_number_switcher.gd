class_name MyNumberSwitcher
extends MyBaseSwitcher

@export var title: String
@export var number_range: Vector2i



func _ready() -> void:
	super()
	prefix_label.text= title


func update_label():
	label.text= str(number_range.x + index)


func get_range()-> int:
	return number_range.y - number_range.x
