class_name ActionBarPanelContainer
extends PanelContainer

signal open_build_list
signal close_build_list
signal open_research_list
signal close_research_list
signal upgrade
signal cancel_upgrade

@onready var build_button: Button = %"Build Button"
@onready var research_button: Button = %"Research Button"



func untoggle_build_button():
	build_button.button_pressed= false


func untoggle_research_button():
	research_button.button_pressed= false


func _on_build_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		open_build_list.emit()
	else:
		close_build_list.emit()


func _on_research_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		open_research_list.emit()
	else:
		close_research_list.emit()


func _on_upgrade_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		upgrade.emit()
	else:
		cancel_upgrade.emit()
