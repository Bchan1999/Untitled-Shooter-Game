extends CharacterBody3D

var player = null

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var health = 12
var state_machine
const ATTACK_RANGE = 2.0
const DAMAGE = 2

@export var player_path : NodePath
@export var nav_agent : NavigationAgent3D

@export var anim_tree: AnimationTree
@export var collisionShape: CollisionShape3D

func _ready() -> void: 
	player = get_node(player_path)
	state_machine = anim_tree.get("parameters/playback")
	SignalBus.bullet_hit.connect(hit)

func _physics_process(delta: float) -> void:
	
	nav_agent.set_target_position(player.global_position)
	var next_nav_point = nav_agent.get_next_path_position()
	
	match state_machine.get_current_node():
		"dance":
			anim_tree.set("parameters/conditions/run", true)
		"run":
			velocity = Vector3.ZERO
			
			look_at(Vector3(next_nav_point.x, global_position.y, next_nav_point.z), Vector3.UP, true)
			velocity = (next_nav_point - global_position).normalized() * SPEED
			
			anim_tree.set("parameters/conditions/attack", target_in_range())

			move_and_slide()
		"attack":
			anim_tree.set("parameters/conditions/run", !target_in_range())
		"death":
			pass
		"hit": 
			look_at(Vector3(next_nav_point.x, global_position.y, next_nav_point.z), Vector3.UP, true)
			anim_tree.set("parameters/conditions/hit", false)
			
func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
	
func hit_player():
	if target_in_range():
		var dir = global_position.direction_to(player.global_position)
		player.hit(DAMAGE, dir)
	
func hit (target, self_damage):
	if target == self:
		health -= self_damage
		if health <= 0:
			anim_tree.set("parameters/conditions/death", true)
		else:
			anim_tree.set("parameters/conditions/hit", true)
		
#func _on_bullet_hit(target: Variant) -> void:
	#if target == self:	
		#print('me enemy been hit')
		#health.take_damage(bullet_damage)
