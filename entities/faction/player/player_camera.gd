extends Camera3D

var move_speed : float = 5
var tilt_speed : float = 2

func _process(delta: float) -> void:
	process_movement_speed()
	process_movement(delta)
	process_camera_tilt(delta)

func process_movement(delta:float) -> void:
	var input_vector := Vector3.ZERO;
	input_vector += Vector3.UP * Input.get_axis("move_down", "move_up")
	input_vector += Vector3.FORWARD * Input.get_axis("move_back", "move_forward")
	input_vector += Vector3.RIGHT * Input.get_axis("move_left", "move_right")
	translate(input_vector * move_speed * delta)
	position.y = clampf(position.y, 2, 20) 

func process_movement_speed() -> void:
	if Input.is_action_just_released("move_increase"):
		move_speed = clampf(move_speed + 1, 1, 10)
	if Input.is_action_just_released("move_decrease"):
		move_speed = clampf(move_speed-1, 1, 10)

func process_camera_tilt(delta: float) -> void:	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		var mouse_move := -Input.get_last_mouse_velocity().normalized()
		mouse_move *= tilt_speed * delta
		rotation.y = rotation.y + mouse_move.x
		rotation.x =clampf(rotation.x + mouse_move.y, -PI/2, 0)
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
