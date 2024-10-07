extends Area3D

func _process(delta: float) -> void:
	global_position += global_basis.z * delta * 25
	#var enemies := get_overlapping_bodies().filter(
		#func(body:Node3D)->bool: return body is EnemyAnt
	#)
	#for enemy:EnemyAnt in enemies: 
		#enemy.hit(6)
#

func _on_body_entered(body: Node3D) -> void:
	if body is EnemyAnt:
		var enemy := body as EnemyAnt
		enemy.hit(6)
