class_name Ant extends CharacterBody3D

@export var damage := 3
@export var max_health := 10
@export var speed:float = 5

@onready var navigation_agent := ($NavigationAgent3D as NavigationAgent3D)
@onready var health := max_health

func on_interact(object:CollisionObject3D, point:Vector3)->void:
	pass

func go_to(target_position:Vector3)->void:
	navigation_agent.target_position = target_position

func hit(damage:int) -> void:
	health -= damage
	if health < 0:
		queue_free()

func _physics_process(_delta: float) -> void:
	var next_step := navigation_agent.get_next_path_position()
	next_step += Vector3.DOWN * 0.5
	var dir := (next_step-global_position).normalized()
	navigation_agent.set_velocity(dir * speed)

func _on_velocity_computed(safe_velocity: Vector3)->void:
	look_at(global_position + (-global_basis.z).lerp(safe_velocity, 0.1))
	
	velocity = safe_velocity
	var __ := move_and_slide()
