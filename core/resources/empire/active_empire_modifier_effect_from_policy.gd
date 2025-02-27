class_name ActiveEmpireModifierEffectFromPolicy
extends Resource

@export var effect: BaseEmpireModifierEffect
@export var lifetime: int= -1
@export var policy: Policy



func apply_type(modifier_type: BaseEmpireModifierEffect.Type, base_value: int)-> int:
	if effect.type != modifier_type:
		return base_value
	return effect.apply_with_ratio(base_value, GameData.get_empire_state().get_policy_ratio(policy))
