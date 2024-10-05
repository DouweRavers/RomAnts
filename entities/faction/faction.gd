class_name Faction extends Node

var buildings:Array[Node3D]:
	get:
		var buildings:Array[Node3D]
		buildings.assign($Buildings.get_children())
		return buildings 
	
var units:Array[Node3D]:
	get: 
		var buildings:Array[Node3D]
		buildings.assign($Units.get_children())
		return buildings 
