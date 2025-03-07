class_name ResearchPopupPanel
extends PopupPanel

signal request_close

@onready var content_container: GridContainer = %"Content GridContainer"



func open():
	populate()
	popup()


func populate():
	UIUtils.free_children(content_container)
	
	var empire_state: EmpireState= GameData.get_empire_state()
	
	var unavailable_techs: Array[Technology]
	for technology in GameData.technologies:
		if not technology.can_research(empire_state):
			unavailable_techs.append(technology)
			continue
		
		var label: Label= UIUtils.add_label(content_container, get_tech_label(technology, empire_state))
		if empire_state.current_research and empire_state.current_research.technology == technology:
			label.add_theme_color_override("font_color", Color.GREEN)
			UIUtils.add_button(content_container, "Researching").disabled= true
		else:
			UIUtils.add_button(content_container, "Research", on_research_pressed, [ technology ])

	for technology in unavailable_techs:
		UIUtils.add_label(content_container, get_tech_label(technology, empire_state)).modulate= Color.INDIAN_RED
		#UIUtils.add_button(content_container, "Research").disabled= true
		UIUtils.add_button(content_container, str("Req. ", technology.required_tech.technology.get_display_name())).disabled= true


func on_research_pressed(technology: Technology):
	GameData.get_empire_state().start_research(technology)
	request_close.emit()
	

func get_tech_label(technology: Technology, empire_state: EmpireState)-> String:
	var add: String= ""
	if technology.has_levels():
		add= str("  ", technology.get_current_level(empire_state) + 1, " / ", technology.get_max_level() + 1)
	return technology.get_display_name() + add
