class_name MyPolicySwitcher
extends MyNumberSwitcher

var policy: BasePolicy



func _ready() -> void:
	title= policy.get_display_name()
	super()


func update_label():
	label.text= "%d (max %d)" % [ number_range.x + index, policy.cap_level ]


func get_range()-> int:
	return min(policy.cap_level, number_range.y) - number_range.x
