extends Node

func _ready() -> void:
	# Get loaded scene
	var node = get_tree().current_scene
	# Check if debug environment is stored
	var path = DebugEnvironmentLib.get_debug_path(node)
	if not FileAccess.file_exists(path): return
	# Replace instance with debug environment
	get_tree().call_deferred("change_scene_to_file",path)
