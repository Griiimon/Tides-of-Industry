class_name ProductionYieldPanelContainer
extends PanelContainer

@export var descriptions: Array[String]

@onready var content: GridContainer = %"Content GridContainer"

var value_labels: Array[Label]
var minus_buttons: Array[Button]
var plus_buttons: Array[Button]



func _ready() -> void:
	SignalManager.production_yields_updated.connect(on_values_updated)
	
	for i in ProductionYields.Type.size():
		UIUtils.add_label(content, descriptions[i])
		value_labels.append(UIUtils.add_label(content, "--%"))
		minus_buttons.append(UIUtils.add_button(content, "-", on_value_changed, [ i, -1 ]))
		plus_buttons.append(UIUtils.add_button(content, "+", on_value_changed, [ i, 1 ]))

	on_values_updated(GameData.get_empire_state().production_yields)


func on_value_changed(type: int, delta: int):
	SignalManager.production_yields_changed.emit(type, delta)


func on_values_updated(yields: ProductionYields):
	for i in ProductionYields.Type.size():
		var val: int= yields.ratios[i]
		value_labels[i].text= str(val, "%")
		minus_buttons[i].disabled= false
		plus_buttons[i].disabled= false
		if val == 0:
			minus_buttons[i].disabled= true
		elif val == 100:
			plus_buttons[i].disabled= true
			
