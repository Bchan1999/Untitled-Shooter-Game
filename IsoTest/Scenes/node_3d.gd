extends Node3D

@export var player_path: NodePath
@export var follow_speed: float = 10.0
@export var fixed_y: float = 32.721  # Set this to your camera's desired Y height

var player: Node3D

func _ready():
	player = get_node(player_path)

func _physics_process(delta: float) -> void:
	pass
	if not player:
		return

	var player_pos = player.global_transform.origin
	var current_pos = global_transform.origin
#
	var target_position = Vector3(
		player_pos.x,
		fixed_y,  # Keep the Y axis fixed
		player_pos.z + 50
	)
	
	print(target_position)
	print("player pos")
	print(player_pos.x, " , " ,player_pos.z)

	global_transform.origin = current_pos.lerp(target_position, delta * follow_speed)
