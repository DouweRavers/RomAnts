class_name Player extends Node

const RAY_LENGTH = 1000.0

static var instance:Player

@onready var raycast := $RayCast3D as RayCast3D

var selected_unit:Ant

func _init() -> void:
	instance = self

func _unhandled_input(event:InputEvent)->void:
	if not event is InputEventMouseButton: return
	var mouse_event := event as InputEventMouseButton
	if not mouse_event.pressed: return
	if mouse_event.button_index == MOUSE_BUTTON_MIDDLE: return
	if mouse_event.button_index == MOUSE_BUTTON_LEFT:
		input_left_mouse_click()
	if mouse_event.button_index == MOUSE_BUTTON_RIGHT:
		input_right_mouse_click()

func _physics_process(_delta: float) -> void:
	process_raycast()

func input_left_mouse_click()->void:
	var collider := raycast.get_collider()
	selected_unit = null
	if collider is Ant:
		var player_unit := collider as Ant
		selected_unit = player_unit
	else:
		PlayerCamp.instance.on_interact(
			raycast.get_collider(),
			raycast.get_collision_point()
			)

func input_right_mouse_click()->void:
	if selected_unit != null:
		selected_unit.on_interact(
			raycast.get_collider(),
			raycast.get_collision_point()
			)
	else:
		if PlayerCamp.instance.active_indicator != null:
			PlayerCamp.instance.active_indicator.queue_free()


func process_raycast()->void:
	var camera := get_viewport().get_camera_3d()
	var mouse_position := get_viewport().get_mouse_position() 
	var from := camera.project_ray_origin(mouse_position)
	var to := from + camera.project_ray_normal(mouse_position) * RAY_LENGTH
	
	raycast.global_position = from
	raycast.target_position = to
	raycast.force_raycast_update()
