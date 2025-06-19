extends Area2D

@export var speed := 800

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _on_body_entered(body: Node2D) -> void:
	SignalBus.emit_bullet_hit(body)
	queue_free()
