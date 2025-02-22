class_name ModifierEffectPercentage
extends BaseModifierEffect

enum Type { POPULATION, PRODUCTION, STABILITY, POLLUTION }

@export var type: Type
@export var factor: float
@export var local: bool= false
