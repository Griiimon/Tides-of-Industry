class_name UnitActionBarPanelContainer
extends PanelContainer

signal close

@onready var button_container: HBoxContainer = %"Button HBoxContainer"

@onready var kill_button: Button = %"Kill Button"

var unit: UnitInstance
var action_buttons: Array[Button]
var font_size: int


func _ready() -> void:
	SignalManager.update_unit_available_actions.connect(on_update_unit_actions)
	font_size= kill_button.get_theme_font_size("font_size")


func activate(_unit: UnitInstance):
	unit= _unit
	
	for button in action_buttons:
		button_container.remove_child(button)
		button.queue_free()
	action_buttons.clear()
	
	for action in unit.type.available_actions:
		var button: Button= UIUtils.add_button(button_container, action.get_display_name(), on_action_button_pressed, [action])
		button.add_theme_font_size_override("font_size", font_size)
		action_buttons.append(button)
		button.disabled= not action.can_execute(unit)
		
	button_container.move_child(kill_button, button_container.get_child_count() - 1)


func on_action_button_pressed(action: BaseUnitAction):
	if action.can_execute(unit):
		if action.execute(unit):
			SignalManager.player_unit_action_executed.emit(unit)


func on_update_unit_actions(_unit: UnitInstance):
	assert(unit == _unit)
	for i in unit.type.available_actions.size():
		action_buttons[i].disabled= not unit.type.available_actions[i].can_execute(unit)


func _on_kill_button_pressed() -> void:
	SignalManager.player_unit_deselected.emit(unit)
	unit.kill()
