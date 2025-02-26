class_name ActiveEmpireModifierEffect
extends Resource

@export var effect: BaseEmpireModifierEffect
@export var lifetime: int= -1



func apply_type(modifier_type: BaseEmpireModifierEffect.Type, base_value: int)-> int:
	if effect.type != modifier_type:
		return base_value
	return effect.apply(base_value)
