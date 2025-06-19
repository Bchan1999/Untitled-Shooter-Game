extends StaticBody2D

@export var player_detect: Area2D
@export var animation_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.package_pickup.connect(package_queue)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func package_queue():
	self.queue_free()

func _on_player_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation_player.play("player_hover")

func _on_player_detect_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation_player.play("idle")
