extends State
class_name EnemyFollow

var player
var speed = 100

var movement_speed: float = 100.0
var movement_target_position

@export var navigation_agent: NavigationAgent2D
@export var enemy: CharacterBody2D
@export var animation : AnimationPlayer

func Enter():
	animation.play("chase")

func _ready():
	#SignalBus.bullet_hit.connect(_on_bullet_hit)
	
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 10

	# Make sure to not await during _ready.
	actor_setup.call_deferred()
	
func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	## Now that the navigation map is no longer empty, set the movement target.
	#set_movement_target(player.global_position)
	
func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target
	
	
func Physics_Update(delta: float) -> void:
	if player:
		set_movement_target(player.global_position)
		#print("This is from enemy: " , player.global_position)
		#velocity = global_position.direction_to(player.global_position) * speed
		##if position.distance_to(player.global_position) > 10:
		#move_and_slide()
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = enemy.global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	enemy.velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	#
#func _on_bullet_hit(target: Variant) -> void:
	#if target == self:	
		#print('me enemy been hit')

func _on_player_far_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
		Transitioned.emit(self, "idle")


func _on_player_far_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		print(player.global_position)
		print("this is player")
