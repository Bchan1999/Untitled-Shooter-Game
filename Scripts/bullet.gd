extends Area2D

@export var speed := 800
@export var  max_distance = 1000

var start = Vector2.ZERO


func ready():
	start = position

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	
	var distance = $CollisionShape2D.position.distance_to(start)
	print(distance)
	# Check if the distance exceeds the limit
	if distance > max_distance:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	SignalBus.emit_bullet_hit(body)
	print(body)
	queue_free()
