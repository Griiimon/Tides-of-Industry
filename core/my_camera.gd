class_name MyCamera
extends Camera2D

enum ZoomState { DEFAULT, IN, OUT }

@export var scroll_speed: float= 250

var zoom_state: ZoomState= ZoomState.DEFAULT:
	set(z):
		if not is_inside_tree(): return
		zoom_state= z
		match zoom_state:
			ZoomState.DEFAULT:
				zoom= Vector2.ONE
			ZoomState.IN:
				zoom= Vector2(2, 2)
			ZoomState.OUT:
				zoom= Vector2(0.25, 0.25)
		


var previous_position: Vector2



func _ready() -> void:
	previous_position= position


func _process(delta: float) -> void:
	if position.distance_squared_to(previous_position) > 1:
		previous_position= position
		SignalManager.camera_moved.emit()

	if Input.is_action_just_pressed("zoom_in"):
		match zoom_state:
			ZoomState.OUT:
				zoom_state= ZoomState.DEFAULT
			ZoomState.DEFAULT:
				zoom_state= ZoomState.IN

	elif Input.is_action_just_pressed("zoom_out"):
		match zoom_state:
			ZoomState.IN:
				zoom_state= ZoomState.DEFAULT
			ZoomState.DEFAULT:
				zoom_state= ZoomState.OUT


func scroll(vec: Vector2, delta: float, speed_factor: float= 1.0):
	position_smoothing_enabled= false
	position+= vec * delta * scroll_speed * speed_factor * 1.0 / zoom.x


func scroll_to(target_pos: Vector2, smooth: bool= true):
	position_smoothing_enabled= smooth
	position= target_pos
