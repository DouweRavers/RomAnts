class_name Game extends Node

static var instance:Game

var score := 0 
var enemies_per_spawn := 1

func _init() -> void:
	instance = self


func _on_timer_timeout() -> void:
	enemies_per_spawn += 1

func game_over()->void:
	process_mode = PROCESS_MODE_DISABLED
	$GameOver.show()
	$GameOver/Label2.text = "Score: %d" % score
