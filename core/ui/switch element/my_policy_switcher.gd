class_name MyPolicySwitcher
extends MyNumberSwitcher

@export var policy: BasePolicy



func _ready() -> void:
	title= policy.get_display_name()
	super()
