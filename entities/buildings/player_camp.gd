class_name PlayerCamp extends Building

static var instance:PlayerCamp

var food_capacity:=100
var wood_capacity:=40
var stone_capacity:=40

var active_indicator:Indicator

func _init() -> void:
	instance = self

func _exit_tree() -> void:
	Game.instance.game_over()

func on_interact(object:CollisionObject3D, point:Vector3)->void:
	if object is Terrain and active_indicator != null:
		if active_indicator.type == Indicator.IndicatorType.ANT_WORKER:
			var worker_scene := load("res://entities/ants/worker_ant.tscn") as PackedScene
			buy_ant(20, point, worker_scene)
		if active_indicator.type == Indicator.IndicatorType.ANT_SOLDIER:
			var soldier_scene := load("res://entities/ants/soldier_ant.tscn") as PackedScene
			buy_ant(40, point, soldier_scene)
		if active_indicator.type == Indicator.IndicatorType.BUILDING_BALISTA:
			var ballista_scene := load("res://entities/buildings/ballista.tscn") as PackedScene
			buy_building(20, 20, point, ballista_scene)

func _on_worker_pressed() -> void:
	if active_indicator != null: active_indicator.queue_free()
	var worker_indicator_scene := load("res://entities/ants/worker_indicator.tscn") as PackedScene
	active_indicator = worker_indicator_scene.instantiate() as Indicator
	add_child(active_indicator)

func _on_soldier_pressed() -> void:
	if active_indicator != null: active_indicator.queue_free()
	var soldier_indicator_scene := load("res://entities/ants/soldier_indicator.tscn") as PackedScene
	active_indicator = soldier_indicator_scene.instantiate() as Indicator
	add_child(active_indicator)


func _on_balista_pressed() -> void:
	if active_indicator != null: active_indicator.queue_free()
	var ballista_indicator_scene := load("res://entities/buildings/balista_indicator.tscn") as PackedScene
	active_indicator = ballista_indicator_scene.instantiate() as Indicator
	add_child(active_indicator)

func buy_ant(food:int, point:Vector3, ant_scene:PackedScene)->void:
	if food_capacity < food: return
	food_capacity -= food
	if food_capacity < food: active_indicator.queue_free()
	var ant:= ant_scene.instantiate() as Ant
	Player.instance.get_node("Ants").add_child(ant)
	ant.global_position = point

func buy_building(stone:int, wood:int, point:Vector3, building_scene:PackedScene)->void:
	if stone_capacity < stone or wood_capacity < wood: return
	stone_capacity -= stone
	wood_capacity -= wood
	if stone_capacity < stone or wood_capacity < wood: active_indicator.queue_free()
	var building:= building_scene.instantiate() as Node3D
	Player.instance.get_node("Buildings").add_child(building)
	building.global_position = point
	Terrain.instance.refresh_navmap()


func _on_timer_timeout() -> void:
	if health < max_health:
		health += 1
