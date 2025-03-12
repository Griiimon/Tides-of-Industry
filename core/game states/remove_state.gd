class_name GameStateRemove
extends GameStateMachineState



func on_enter():
	SignalManager.force_pause.emit()


func on_exit():
	SignalManager.cancel_forced_pause.emit()
