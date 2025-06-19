extends Node2D

@export var marker : Marker2D

func get_marker2d_global_position() -> Vector2:
	return marker.global_position
