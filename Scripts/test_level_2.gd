extends Node2D

@export var area = CollisionShape2D

func get_level_coord() -> Rect2:
	#print("this is local to scene: " , area.position)
	#print("this is local size to scene: " , area.shape.get_rect().size)
	#print("this is global to scene: " , area.global_position)
	return area.shape.get_rect()
	
