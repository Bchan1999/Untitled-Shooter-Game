extends StaticBody3D

@export var anim : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("idle")
	pass # Replace with function body.


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		anim.play("toggle_talk")
		
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		anim.play("idle")
