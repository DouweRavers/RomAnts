extends MeshInstance3D

@export var type:CollectableResource.ResourceType
@export var ant:WorkerAnt

func _process(delta: float) -> void:
	visible = ant.capacity > 0 and \
		ant.target is PlayerCamp and \
		ant.source_target.type == type
