extends MeshInstance3D

func _on_mouse_entered() -> void:
	var overlay_material := preload("res://resources/selectable_overlay.tres") as StandardMaterial3D
	material_overlay = overlay_material

func _on_mouse_exited() -> void:
	material_overlay = null
