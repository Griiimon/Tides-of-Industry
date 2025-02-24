class_name ProductionYields
extends Resource

enum Type { MONEY, CONSTRUCTION_POINTS, RESEARCH }

const STEP_SIZE= 10


@export var ratios: Array[int]= [ 20, 50, 30 ]



func _init():
	connect_signals.call_deferred()


func connect_signals():
	SignalManager.production_yields_changed.connect(change_ratio)


func change_ratio(type: Type, delta: int):
	if delta == 0: return
	
	delta*= STEP_SIZE
	
	var val: int= ratios[type]
	if val + delta > 100:
		delta= 100 - val
	elif val + delta < 0:
		delta= -val
	
	ratios[type]+= delta
	
	var other_indices: Array[int]
	other_indices.assign(Type.values())
	
	other_indices.erase(type)
	var other_target: int= 100 if delta > 0 else 0
	 
	while abs(delta) > 0:
		if ratios[other_indices[0]] - delta != clampi(ratios[other_indices[0]] - delta, 0, 100):
			ratios[other_indices[1]]-= delta
		elif ratios[other_indices[1]] - delta != clampi(ratios[other_indices[1]] - delta, 0, 100):
			ratios[other_indices[0]]-= delta
		elif abs(other_target - ratios[other_indices[0]]) > abs(other_target - ratios[other_indices[1]]):
			ratios[other_indices[1]]-= delta
		else:
			ratios[other_indices[0]]-= delta

		delta+= -sign(delta) * STEP_SIZE

	assert(ratios.reduce(func sum(accum, number): return accum + number, 0) == 100)




	SignalManager.production_yields_updated.emit(self)
