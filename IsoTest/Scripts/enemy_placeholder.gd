extends CharacterBody3D

var MAX_HEALTH = 10
var curr_health = MAX_HEALTH

var mat1 = preload("res://IsoTest/Material/enemy_placeholder.tres")
var mat2 = preload("res://IsoTest/Material/enemy_placeholder_hurt.tres")

var player = null
const SPEED = 3.0

@export var timer : Timer
@export var nav_agent : NavigationAgent3D

func _physics_process(delta: float) -> void:
	if player: 
		nav_agent.set_target_position(player.global_position)
		print(nav_agent.get_next_path_position())
		var next_nav_point = nav_agent.get_next_path_position()
		
		velocity = Vector3.ZERO
			
		look_at(Vector3(next_nav_point.x, global_position.y, next_nav_point.z), Vector3.UP, true)
		velocity = (next_nav_point - global_position).normalized() * SPEED
	

	move_and_slide()

func this_thing_take_damage(dmg):
	timer.start()
	print("ouchie")
	var red = Color(1.0, 0.0, 0.0, 1.0)
	$MeshInstance3D.set_surface_override_material(0, mat2)
	print("taking damage")
	curr_health -= dmg
	curr_health = clampf(curr_health, 0, MAX_HEALTH)
	if curr_health <= 0:
		print("ME DEAD")

func _on_hurt_anim_timeout() -> void:
	$MeshInstance3D.set_surface_override_material(0, mat1)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = body
