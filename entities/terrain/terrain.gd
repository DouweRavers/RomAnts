class_name Terrain extends StaticBody3D

static var instance:Terrain

func _init() -> void:
	instance = self

func _ready() -> void:
	refresh_navmap()

func refresh_navmap()->void:
	$NavigationRegion3D.bake_navigation_mesh()
	
