class_name TopBarPanelContainer
extends PanelContainer

@onready var island_container: HBoxContainer = %"Island HBoxContainer"
@onready var empire_container: HBoxContainer = %"Empire HBoxContainer"


@onready var island_name_label: Label = %"Island Name Label"
@onready var population_label: Label = %"Population Label"
@onready var production_label: Label = %"Production Label"
@onready var pollution_label: Label = %"Pollution Label"
@onready var power_label: Label = %"Power Label"
@onready var research_label: Label = %"Research Label"

@onready var stability_label: Label = %"Stability Label"
@onready var money_label: Label = %"Money Label"
@onready var turn_label: Label = %"Turn Label"



func update(island: IslandInstance):
	if not island:
		island_container.hide()
	else:
		island_name_label.text= island.definition.name
		population_label.text= str("Pop: ", island.population)
		production_label.text= str("Prod: ", island.production)
		pollution_label.text= str("Poll: ", island.pollution)
		power_label.text= str("Pow: ", island.power)
		research_label.text= str("Res: ", island.research)
	
	stability_label.text= str("Stab: ", GameData.empire.stability)
	money_label.text= str("$", GameData.empire.money)
	turn_label.text= str("Turn ", GameData.world_state.turns)
