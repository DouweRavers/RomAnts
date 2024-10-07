class_name CollectableResource extends StaticBody3D

enum ResourceType {FOOD, STONE, WOOD}
@export var type:ResourceType

var capacity := 100

func collect(amount:int)->int:
	if capacity > amount:
		capacity -= amount
		return amount
	else:
		var remains := capacity
		capacity = 0
		return remains

func _on_tick() -> void:
	if capacity < 100: return
	capacity += 10
