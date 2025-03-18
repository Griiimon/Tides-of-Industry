class_name Population
extends Resource

@export var political_view_ratios: Dictionary 	# [ PoliticalView ] => float



func add_political_view(view: PoliticalView):
	assert(not political_view_ratios.has(view))
	political_view_ratios[view]= 0.0


func get_total_pop_with_view(view: PoliticalView, pop_size: int)-> int:
	if not political_view_ratios.has(view): return 0
	if view.has_pop_cap():
		pop_size= view.pop_cap
	return pop_size * political_view_ratios[view]
