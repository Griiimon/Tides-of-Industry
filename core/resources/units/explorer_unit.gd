class_name ExplorerUnit
extends AmphibiousUnit



func get_los()-> int:
	return super() + GameData.get_empire_state().get_policy_modifier(BasePolicy.Modifier.EXPLORER_LOS_BONUS)
