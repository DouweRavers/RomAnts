class_name Indicator extends Node3D

enum IndicatorType {
	ANT_WORKER, ANT_SOLDIER, BUILDING_BALISTA,
	OTHER
}

@export var type:IndicatorType
 
func _process(_delta: float) -> void:
	var raycast := Player.instance.raycast
	if raycast.get_collider() is Terrain:
		visible = true
		global_position = raycast.get_collision_point()
	else:
		visible = false
