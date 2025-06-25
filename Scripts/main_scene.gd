extends Node2D

@export var player_scene: PackedScene
@export var camera_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit() # default behavior
