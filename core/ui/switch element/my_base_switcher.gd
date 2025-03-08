class_name MyBaseSwitcher
extends HBoxContainer

signal switched()

@export var min_size: int= 100
@export var wrap_around: bool= true

@onready var label: Label = %Label
@onready var prefix_label: Label = $"Prefix Label"

var index: int



func _ready() -> void:
	label.custom_minimum_size.x= min_size
	update_label.call_deferred()


func _on_texture_button_pressed(delta: int) -> void:
	if wrap_around:
		index= wrapi(index + delta, 0, get_range())
	else:
		var prev_index: int= index
		index= clampi(index + delta, 0, get_range())
		if prev_index == index: return
		
	switched.emit()
	update_label()


func update_label():
	pass


func _on_margin_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and not event.is_echo():
			_on_texture_button_pressed(1)


func go_back():
	_on_texture_button_pressed(-1)


func get_range()-> int:
	return 0
