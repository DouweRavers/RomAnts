class_name Ballista extends Building


var target:EnemyAnt
var arrow_scene := preload("res://entities/buildings/Arrow.tscn")

func _process(delta: float) -> void:
	if target != null:
		$pivot.look_at(target.global_position)

func _on_timer_timeout() -> void:
	if target == null or target.global_position.distance_to(global_position)>50:
		var target_area := $targetArea as Area3D
		var targets := target_area.get_overlapping_bodies().filter(
			func(body:Node3D)->bool: return body is EnemyAnt
		)
		if targets.is_empty(): return
		target = targets.pick_random()
	var arrow := arrow_scene.instantiate() as Area3D
	$pivot.add_child(arrow)
	arrow.rotation.y = PI
	arrow.global_position = $pivot.global_position + Vector3.UP*0.25
