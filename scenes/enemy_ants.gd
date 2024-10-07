class_name EnemySpawn extends Node3D


var enemy_scene := preload("res://entities/ants/enemy_ant.tscn")

func _ready() -> void:
	$Timer.wait_time = randi_range(1, 10)
	$Timer.start()

func _on_timer_timeout() -> void:
	$Timer.wait_time = randi_range(1, 10)
	if $Ants.get_children().size() < Game.instance.enemies_per_spawn:
		var enemy := enemy_scene.instantiate() as EnemyAnt
		$Ants.add_child(enemy)
		enemy.global_position = global_position
