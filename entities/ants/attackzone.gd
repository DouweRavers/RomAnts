extends Area3D

signal attack

func _on_attack_timer_timeout() -> void:
	var ant := get_parent() as Ant
	for body in get_overlapping_bodies():
		if body is Ant:
			var other_ant := body as Ant
			if ant is SoldierAnt and other_ant is EnemyAnt:
				other_ant.hit(randi_range(0, ant.damage))
				attack.emit()
			if ant is EnemyAnt and other_ant is not EnemyAnt:
				other_ant.hit(randi_range(0, ant.damage))
				attack.emit()
	if ant is SoldierAnt: return
	for area in get_overlapping_areas():
		if area.get_parent() is Building:
			var building := area.get_parent() as Building
			building.hit(randi_range(0, ant.damage))
			attack.emit()
