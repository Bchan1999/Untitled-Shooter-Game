extends Camera2D

@export var player: CharacterBody2D
@export var cursor_influence: float = 0.1  # How much the cursor affects camera position (0 to 1)
@export var smooth_speed: float = 2.0      # Higher value for smoother, faster response

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Get the player's position and the cursor's position
	var player_pos = player.global_position
	var cursor_pos = get_viewport().get_mouse_position()
	
	# Convert cursor position to world coordinates
	var camera_rect = get_viewport_rect()
	var cursor_world_pos = global_position - (camera_rect.size / 2) + cursor_pos
	
	# Calculate the target position by blending player and cursor positions
	var target_pos = player_pos.lerp(cursor_world_pos, cursor_influence)
	
	# Smoothly move the camera to the target position
	global_position = global_position.lerp(target_pos, 1.0 - exp(-smooth_speed * delta))
