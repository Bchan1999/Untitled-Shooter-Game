extends Node2D

@export var area = CollisionShape2D
@onready var level_management = get_node("../LevelManagement")

func get_level_coord() -> Rect2:
	#print("this is local to scene: " , area.position)
	#print("this is local size to scene: " , area.shape.get_rect().size)
	#print("this is global to scene: " , warea.global_position)
	return area.shape.get_rect()

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#print("you entered me")
	#level_management.emit_room_change("room2")
	#queue_free()
