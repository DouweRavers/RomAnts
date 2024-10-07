class_name Building extends StaticBody3D

@export var max_health := 10
@onready var health := max_health

func hit(damage:int) -> void:
	health -= damage
	if health < 0:
		queue_free()
