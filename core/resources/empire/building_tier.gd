class_name BuildingTier
extends Resource

@export var building: Building
@export var tier: int



func _init(_building: Building= null, _tier: int= 0) -> void:
	building= _building
	tier= _tier


func is_at_least(building_tier: BuildingTier)-> bool:
	if building != building_tier.building: return false
	return tier >= building_tier.tier
