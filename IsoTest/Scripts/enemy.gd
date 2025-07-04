extends CharacterBody3D

var player = null

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var health = 12
var state_machine
const ATTACK_RANGE = 2.0

@export var player_path : NodePath
@export var nav_agent : NavigationAgent3D

@export var anim_tree: AnimationTree
@export var collisionShape: CollisionShape3D

func _ready() -> void: 
	player = get_node(player_path)
	state_machine = anim_tree.get("parameters/playback")

func _physics_process(delta: float) -> void:
	match state_machine.get_current_node():
		"dance":
			anim_tree.set("parameters/conditions/run", true)
		"run":
			velocity = Vector3.ZERO
			
			nav_agent.set_target_position(player.global_position)
			var next_nav_point = nav_agent.get_next_path_position()
			look_at(Vector3(next_nav_point.x, global_position.y, next_nav_point.z), Vector3.UP, true)
			velocity = (next_nav_point - global_position).normalized() * SPEED

			move_and_slide()
		"death":
			pass
		"hit": 
			pass
			
func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
