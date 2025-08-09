extends Node3D

@export var player_path: NodePath
@export var follow_speed: float = 10.0
@export var fixed_y: float = 32.721  # Set this to your camera's desired Y height

@onready var camera = $Camera3D2

@export var randomStrength : float = 0.3
@export var shakeFade: float = 80.0

var rng = RandomNumberGenerator.new()
var shake_strength : float = 0.0

var player: Node3D

func _ready():
	player = get_node(player_path)
	SignalBus.bullet_hit.connect(bullet_hit)

func _physics_process(delta: float) -> void:
	pass
	if not player:
		return

	var player_pos = player.global_transform.origin
	var current_pos = global_transform.origin
#
	var target_position = Vector3(
		player_pos.x,
		fixed_y,  # Keep the Y axis fixed
		player_pos.z + 50
	)

	global_transform.origin = current_pos.lerp(target_position, delta * follow_speed)


	
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("shoot"):
		#apply_shake()
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta)
		
		camera.h_offset = randomOffset().x
		camera.v_offset = randomOffset().y

func bullet_hit(target, self_damage):
	apply_shake()
	
func apply_shake():
	shake_strength = randomStrength
	
func randomOffset():
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
