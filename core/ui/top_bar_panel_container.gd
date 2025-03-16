class_name TopBarPanelContainer
extends PanelContainer

@onready var city_container: HBoxContainer = %"City HBoxContainer"
@onready var empire_container: HBoxContainer = %"Empire HBoxContainer"


@onready var city_name_label: Label = %"City Name Label"
@onready var population_label: Label = %"Population Label"
@onready var production_label: Label = %"Production Label"
@onready var pollution_label: Label = %"Pollution Label"
@onready var power_label: Label = %"Power Label"
@onready var research_label: Label = %"Research Label"

@onready var stability_label: Label = %"Stability Label"
@onready var construction_points_label: Label = %"Construction Points Label"
@onready var money_label: Label = %"Money Label"
@onready var turn_label: Label = %"Turn Label"



func update(city: CityInstance):
	if not city:
		city_container.hide()
	else:
		city_name_label.text= city.definition.name
		population_label.text= str("Pop: %d (%d)" % [ city.population, city.max_workers ])
		production_label.text= str("Prod: %d (%d x %.2f)" % [ city.production, city.base_production, city.workers_ratio ])
		pollution_label.text= str("Poll: ", city.pollution)
		power_label.text= str("Pow: %d/%d" % [ city.power, city.base_power ])
		research_label.text= str("Res: ", city.research)
	
		city_container.show()
		
		
	var empire_state: EmpireState= GameData.get_empire_state()
	
	stability_label.text= str("Stab: ", int(empire_state.stability), "%")
	construction_points_label.text= str("CP: ", int(empire_state.construction_points))
	money_label.text= str("$", int(empire_state.money))
	turn_label.text= str("Turn ", GameData.world_state.turns)
