class_name BuildingListPanelContainer
extends PanelContainer

signal selected(building: Building, tier: int)

@onready var content: GridContainer = %"Content GridContainer"



func _ready() -> void:
	# TODO unbind correct use?
	SignalManager.technology_researched.connect(populate.unbind(1))
	
	populate()


func populate():
	UIUtils.free_children(content)
	
	for building in GameData.buildings:
		if not building.available_in_build_menu and not ( DebugSettings.is_enabled() and DebugSettings.only_allow_buildings_in_list ):
			continue

		var label: Label= UIUtils.add_label(content, building.get_display_name())

		for tier in 3:
			if tier <= building.get_max_level():
				var button: Button= UIUtils.add_button(content, str("Tier ", tier + 1), on_build.bind(building, tier))
				button.disabled= not GameData.get_empire_state().is_building_unlocked(BuildingTier.new(building, tier))
			else:
				UIUtils.add_empty(content)


func on_build(building: Building, tier: int):
	selected.emit(building, tier)
