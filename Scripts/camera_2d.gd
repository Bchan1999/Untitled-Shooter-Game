extends Camera2D

@export var player : CharacterBody2D
@export var cursor_influence: float = 0.1  # How much the cursor affects camera position (0 to 1)
@export var smooth_speed: float = 2.0      # Higher value for smoother, faster response
var target_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Get the player's position and the cursor's position
	if player:
		var target_pos = follow_player()
		update_camera(delta , target_pos)
	
func camera_limit(level):
	var level_rect : Rect2 = level.get_level_coord()
	var global_level_rect_pos = level.global_position
	
	limit_right = global_level_rect_pos.x + level_rect.size.x
	limit_left = global_level_rect_pos.x - level_rect.size.x
	limit_bottom = global_level_rect_pos.y + level_rect.size.y
	limit_top = global_level_rect_pos.y - level_rect.size.y
	
func follow_player() -> Vector2:
		var player_pos = player.global_position
		var cursor_pos = get_viewport().get_mouse_position()
		
		# Convert cursor position to world coordinates
		var camera_rect = get_viewport_rect()
		var cursor_world_pos = global_position - (camera_rect.size / 2) + cursor_pos
		
		# Calculate the target position by blending player and cursor positions
		target_pos = player_pos.lerp(cursor_world_pos, cursor_influence)
		return target_pos
		

func update_camera(delta, target_pos):
	# Smoothly move the camera to the target position
	global_position = global_position.lerp(target_pos, 1.0 - exp(-smooth_speed * delta))
	
func set_target_pos(new_target_pos):
	target_pos = new_target_pos
