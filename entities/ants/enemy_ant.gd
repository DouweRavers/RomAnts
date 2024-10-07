class_name EnemyAnt extends Ant

var ant_target:Ant
var building_target:Building

func _process(delta: float) -> void:
	var value := $enemy/AnimationTree.get("parameters/Walk/blend_position") as float
	var speed_anim := lerpf(value, velocity.length()/speed, delta*5)
	$enemy/AnimationTree.set("parameters/Walk/blend_position", speed_anim)

func _exit_tree() -> void:
	Game.instance.score += 1

func search_target()->void:
	var player_ants := Player.instance.get_node("Ants").get_children()
	ant_target = player_ants.reduce(
		func(closest_ant:Ant,new_ant:Ant)->Ant:
			var closest_dist := closest_ant.global_position.distance_squared_to(global_position)
			var new_dist := new_ant.global_position.distance_squared_to(global_position)
			return new_ant if new_dist<closest_dist else closest_ant
	) as Ant
	if ant_target == null:
		var player_buildings := Player.instance.get_node("Buildings").get_children()
		building_target = player_buildings.reduce(
			func(closest_building:Building,new_building:Building)->Building:
				var closest_dist := closest_building.global_position.distance_squared_to(global_position)
				var new_dist := new_building.global_position.distance_squared_to(global_position)
				return new_building if new_dist<closest_dist else closest_building
		) as Building


func _on_enemy_tracker_timer_timeout() -> void:
	if (ant_target==null and building_target==null) or randi_range(0,10) == 0:
		search_target()
	if ant_target!=null: go_to(ant_target.global_position)
	if building_target!=null: go_to(building_target.global_position)


func _on_attackzone_attack() -> void:
	if ant_target!=null: look_at(ant_target.global_position)
	if building_target!=null: look_at(building_target.global_position)
	var state_machine := $enemy/AnimationTree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	state_machine.travel("Attack")
