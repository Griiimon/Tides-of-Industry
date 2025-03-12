class_name PoliciesPopupPanel
extends PopupPanel

@export var policy_switcher_scene: PackedScene

@onready var content: VBoxContainer = %"Content VBoxContainer"
@onready var reform_points_label: Label = %"Reform Points Label"
@onready var specialization_points_label: Label = %"Specialization Points Label"

var switchers: Array[MyPolicySwitcher]



func open():
	update()
	popup()


func update():
	var empire_state: EmpireState= GameData.get_empire_state()
	if content.get_child_count() == 0:
		for policy in empire_state.policies:
			var switcher: MyPolicySwitcher= policy_switcher_scene.instantiate()
			switcher.policy= policy
			switcher.switched.connect(on_policy_changed.bind(switcher))
			content.add_child(switcher)
			switchers.append(switcher)
	
	for switcher in switchers:
		switcher.disabled= empire_state.reform_points < 1
	
	reform_points_label.text= "Reform points: %.3f (+%.3f)" % [ empire_state.reform_points, empire_state.reform_points_increase ]
	specialization_points_label.text= "Next Specialist: %d/%d (+%.2f)" % [ empire_state.specialist_points, empire_state.specialist_points_required, empire_state.specialist_points_increase ]
	

func on_policy_changed(switcher: MyPolicySwitcher):
	switcher.policy.level= switcher.index
	GameData.get_empire_state().reform_points-= 1
	update()
