class_name ActionBarPanelContainer
extends PanelContainer

signal open_build_list
signal close_build_list


@onready var build_button: Button = %"Build Button"



func untoggle_build_button():
	build_button.button_pressed= false


func _on_build_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		open_build_list.emit()
	else:
		close_build_list.emit()
