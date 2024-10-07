extends Node3D


func _process(delta: float) -> void:
	var parent := get_parent() as Ant
	visible = Player.instance.selected_unit == parent
