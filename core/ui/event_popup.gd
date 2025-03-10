class_name EventPopup
extends PopupPanel

@onready var description_label: Label = %"Description Label"
@onready var default_button: Button = %"Default Button"
@onready var option_button: Button = %"Option Button"

var event: BaseEvent



func open(_event: BaseEvent):
	event= _event
	title= event.title
	description_label.text= event.get_description()
	
	default_button.text= event.confirm_cancel_button
	option_button.visible= event.has_choice
	option_button.text= event.option_button
	
	SignalManager.force_pause.emit()
	popup()


func _on_default_button_pressed() -> void:
	hide()
	SignalManager.closed_event_popup.emit(true)
	SignalManager.cancel_forced_pause.emit()


func _on_option_button_pressed() -> void:
	hide()
	SignalManager.closed_event_popup.emit(false)
	SignalManager.cancel_forced_pause.emit()
