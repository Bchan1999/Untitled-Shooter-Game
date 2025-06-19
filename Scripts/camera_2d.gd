extends Camera2D

@export var player: CharacterBody2D
@export var area_limit: CameraLimit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position = player.global_position
	#area_limit.get_rect_bounds()
	
