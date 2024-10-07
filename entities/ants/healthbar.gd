extends Node3D


func _process(delta: float) -> void:
	var health:int
	var max_health:int
	if get_parent() is Ant:
		var ant := get_parent() as Ant
		health = ant.health
		max_health = ant.max_health
	elif get_parent() is Building:
		var building := get_parent() as Building
		health = building.health
		max_health = building.max_health
	
	var bar := $Sprite3D/SubViewport/HSlider as HSlider
	bar.max_value = max_health
	bar.value = health
