extends Node3D

@export var speed: float = 5.0  # Movement speed towards the player
var player: Node3D = null  # Reference to the player
var is_moving: bool = false  # Track if the object should move

# Called when something enters the Area3D
func _on_area_3d_body_entered(body: Node) -> void:
	if body.is_in_group("player"):  # Check if the entering body is the player
		player = body
		is_moving = true

# Called when something exits the Area3D
func _on_area_3d_body_exited(body: Node) -> void:
	if body.is_in_group("player"):  # Stop moving when player exits
		player = null
		is_moving = false

# Called every frame
func _process(delta: float) -> void:
	if is_moving and player:
		# Calculate direction to player
		var direction = (player.global_position - global_position).normalized()
		# Move towards the player
		global_position += direction * speed * delta

func _on_absorb_detect_area_entered(area: Area3D) -> void:
	if (area.is_in_group('absorb')):
		self.queue_free()
