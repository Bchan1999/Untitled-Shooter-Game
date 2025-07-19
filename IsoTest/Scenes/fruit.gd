extends RigidBody3D

var player : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y = 2
	if player:
		position = position.lerp(player.position, 0.04)

func _on_area_3d_area_entered(area: Area3D) -> void:
	if (area.get_parent().is_in_group("player")):
		player = area.get_parent()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body.is_in_group("player")):
		if player:
			player.item_absorbed()
		queue_free()
