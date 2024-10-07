class_name WorkerAnt extends Ant

var capacity:=0
var target:Node3D
var source_target:CollectableResource

func _enter_tree() -> void:
	Game.instance.score += 1
	
func _process(delta: float) -> void:
	if Player.instance.selected_unit == self:
		$image.visible = true
	else:
		$image.visible = false
	$base_ant/AnimationTree.set("parameters/blend_position", velocity.length()/speed)

func on_interact(object:CollisionObject3D, point:Vector3)->void:
	target = null
	source_target = null
	if object is Terrain:
		go_to(point)
	elif object is CollectableResource:
		var resource := object as CollectableResource
		target = resource
		source_target = resource
		go_to(target.global_position)

func _on_target_reached() -> void:
	if target is CollectableResource:
		var resource := target as CollectableResource
		capacity = resource.collect(5)
		target = PlayerCamp.instance
		go_to(target.global_position)
	elif target is PlayerCamp:
		var camp := target as PlayerCamp
		match source_target.type:
			CollectableResource.ResourceType.FOOD:
				camp.food_capacity += capacity
			CollectableResource.ResourceType.WOOD:
				camp.wood_capacity += capacity
			CollectableResource.ResourceType.STONE:
				camp.stone_capacity += capacity
		capacity = 0
		target = source_target
		go_to(target.global_position)
