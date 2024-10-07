class_name SoldierAnt extends Ant

var target:EnemyAnt

func _enter_tree() -> void:
	Game.instance.score += 1

func _process(delta: float) -> void:
	if Player.instance.selected_unit == self:
		$image.visible = true
	else:
		$image.visible = false
	var value := $soldier/AnimationTree.get("parameters/Walk/blend_position") as float
	var speed_anim := lerpf(value, velocity.length()/speed, delta*5)
	$soldier/AnimationTree.set("parameters/Walk/blend_position", speed_anim)

func on_interact(object:CollisionObject3D, point:Vector3)->void:
	target = null
	if object is Terrain:
		go_to(point)
	elif object is EnemyAnt:
		var enemy := object as EnemyAnt
		target = enemy
		go_to(target.global_position)

func _on_target_reached() -> void:
	if target == null: return
	look_at(target.global_position)

func _on_enemy_tracker_timer_timeout() -> void:
	if target == null: 
		var enemy_detectoion := $enemyDetection as Area3D
		target = enemy_detectoion.get_overlapping_bodies().filter(
			func(ant:Ant)->bool: return ant is EnemyAnt 
		).reduce(
			func(closest_ant:Ant,new_ant:Ant)->Ant:
				var closest_dist := closest_ant.global_position.distance_squared_to(global_position)
				var new_dist := new_ant.global_position.distance_squared_to(global_position)
				return new_ant if new_dist<closest_dist else closest_ant
		) as EnemyAnt
	else:
		go_to(target.global_position)

func _on_attackzone_attack() -> void:
	var state_machine := $soldier/AnimationTree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	state_machine.travel("Attack")
