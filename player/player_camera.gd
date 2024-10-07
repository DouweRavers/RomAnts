class_name PlayerCamera extends Camera3D

var move_speed : float = 10
var tilt_speed : float = 2

func _process(delta: float) -> void:
	process_movement(delta)
	process_camera_tilt(delta)

func process_movement(delta:float) -> void:
	var input_vector := Vector3.ZERO;
	input_vector += -global_basis.z * Input.get_axis("move_back", "move_forward")
	input_vector += global_basis.x * Input.get_axis("move_left", "move_right")
	input_vector.y = 0;
	input_vector += Vector3.UP * Input.get_axis("move_down", "move_up")
	
	var speed_scaler := lerpf(0.3, 3, global_position.y/20)
	global_position += input_vector * move_speed * speed_scaler * delta
	position.y = clampf(position.y, 2, 20) 

func process_camera_tilt(delta: float) -> void:	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		var mouse_move := -Input.get_last_mouse_velocity()
		mouse_move /= get_viewport().size as Vector2
		mouse_move *= tilt_speed * delta
		rotation.y = rotation.y + mouse_move.x
		rotation.x =clampf(rotation.x + mouse_move.y, -PI/2, 0)
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
