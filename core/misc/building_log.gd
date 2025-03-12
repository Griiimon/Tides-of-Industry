class_name BuildingLog

var entries: Dictionary


func log_stat(stat: Building.Stat, label: String, value):
	entries[stat].append([label, Utils.signed_number(value)])


func clear_stat(stat: Building.Stat):
	entries[stat]= []


func get_label(idx: int)-> String:
	var ctr: int= 0
	for stat: Building.Stat in entries.keys():
		for entry: Array in entries[stat]:
			if ctr == idx:
				var label: String= entry[0]
				return str(Building.Stat.keys()[stat].to_pascal_case(), " (", label, ")")
			ctr+= 1
	assert(false)
	return ""


func get_value(idx: int)-> String:
	var ctr: int= 0
	for stat: Building.Stat in entries.keys():
		for entry: Array in entries[stat]:
			if ctr == idx:
				var value: String= entry[1]
				return value
			ctr+= 1
	assert(false)
	return ""
	

func get_total_entries()-> int:
	var result: int= 0
	for arr: Array in entries.values():
		result+= arr.size()
	return result
