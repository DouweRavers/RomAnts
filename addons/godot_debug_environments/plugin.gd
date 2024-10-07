@tool
class_name DebugEnvironmentPlugin extends EditorPlugin

static var instance:DebugEnvironmentPlugin

var inspector:DebugEnvironmentInspector

func _enter_tree():
	instance = self
	var inspector_script := load("res://addons/godot_debug_environments/inspector.gd") as GDScript
	inspector = inspector_script.new()
	add_inspector_plugin(inspector)
	add_autoload_singleton("DebugEnvironmentWatcher", "res://addons/godot_debug_environments/watcher.gd")

func _exit_tree():
	remove_inspector_plugin(inspector)
	remove_autoload_singleton("DebugEnvironmentWatcher")
