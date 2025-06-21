extends Node2D

@export var marker : Marker2D
@export var bullet : Sprite2D

func get_marker2d_global_position() -> Vector2:
	return marker.global_position
	
func _physics_process(delta: float) -> void:
	# Flip sprite based on rotation
	if rotation_degrees >= -89 and rotation_degrees <= 90:
		bullet.flip_v = false  # Default (unflipped) for -89 to 90 degrees
	else:
		bullet.flip_v = true   # Flipped for -90 to -180 or 90 to 180 degrees
