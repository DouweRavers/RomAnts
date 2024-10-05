class_name FogOfWar extends Node

@export var visual:bool = true
@export var width:int = 20
@export var height:int = 20

var size:int:
	get: return width*height

var faction:Faction:
	get: return get_parent() as Faction

var grid:Array[bool] = []

func _ready() -> void:
	if not visual: $FogOfWarVisual.queue_free()
	generate_new_grid()
	visualize_grid()

func _on_tick() -> void:
	update_fog_of_war()
	visualize_grid()

func generate_new_grid()->void:
	grid.resize(size)
	for i in range(size):
		grid[i] = true

func visualize_grid()->void:
	if not has_node("FogOfWarVisual"): return
	var fog_of_war_visual := $FogOfWarVisual as GridMap
	for i in range(size):
		var item := 0 if grid[i] else -1
		fog_of_war_visual.set_cell_item(c2p(i2c(i)), item)

func update_fog_of_war()->void:
	var entities := faction.buildings + faction.units
	for i in range(size):
		grid[i] = grid[i] and not entities.map(
			func(entity:Node3D)->bool:
				return entity.position.distance_squared_to(c2p(i2c(i))) < 10
		).has(true)

# Converters from coordinates to index values
func c2i(coor:Vector2i)->int: return coor.x+coor.y*width
func i2c(index:int)->Vector2i: return Vector2i(index%width, index/width)
func c2p(coor:Vector2i)->Vector3i: return Vector3i(coor.x-width/2, 0, coor.y-height/2)
