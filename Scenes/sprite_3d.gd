extends Sprite3D

@export var player : CharacterBody3D

func _process(delta):
	global_position.y = (player.global_position.z / 2) + 15
