extends Node2D

@onready var static_body = $StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#SignalBus.connect("bullet_hit", _on_bullet_hit(), 1)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage() -> void:
	pass
