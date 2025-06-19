extends CameraLimit

#@export var top_limit: int = 10
#@export var left_limit: int = 10
#@export var right_limit: int = 10
#@export var bottom_limit: int = 10
@export var camera_bounds: Rect2

func get_bounds() -> Rect2:
	return camera_bounds

#func get_top() -> int:
	#return top_limit
#
#func get_left() -> int:
	#return left_limit
	#
#func get_right() -> int:
	#return right_limit
	#
#func get_bottom() -> int:
	#return bottom_limit
