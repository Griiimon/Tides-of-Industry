class_name GameStateRemove
extends GameStateMachineState



func on_enter():
	SignalManager.force_pause.emit()


func on_exit(re_enter_same_state: bool):
	SignalManager.cancel_forced_pause.emit()
