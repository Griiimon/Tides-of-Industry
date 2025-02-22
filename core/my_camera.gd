class_name MyCamera
extends Camera2D

@export var scroll_speed: float= 250


var previous_position: Vector2



func _ready() -> void:
	previous_position= position


func _process(delta: float) -> void:
	if position.distance_squared_to(previous_position) > 1:
		previous_position= position
		SignalManager.camera_moved.emit()


func scroll(vec: Vector2, delta: float, speed_factor: float= 1.0):
	position_smoothing_enabled= false
	position+= vec * delta * scroll_speed * speed_factor


func scroll_to(target_pos: Vector2, smooth: bool= true):
	position_smoothing_enabled= smooth
	position= target_pos
