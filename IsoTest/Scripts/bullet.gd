extends Area3D

signal exploded

@export var muzzle_velocity = 50
@export var g = Vector3.DOWN * 20
var velocity = Vector3.ZERO
var start_pos = Vector2.ZERO
@export var distance = 60
@export var particles : GPUParticles3D

func _ready() -> void:
	start_pos = global_position

func _physics_process(delta):
	velocity += g * delta
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta
	
	var how_far = start_pos.distance_to(global_position)
	
	if how_far > distance:
		queue_free()
	
	#if (global_position >)

func _on_body_entered(body: Node3D) -> void:
	SignalBus.emit_bullet_hit(body, 2)
	particles.emitting = true
	await get_tree().create_timer(1.0).timeout
	queue_free()
