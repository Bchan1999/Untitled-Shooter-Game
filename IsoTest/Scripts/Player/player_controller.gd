extends CharacterBody3D
class_name PlayerController

#@export_category("Gun")
#@export var gun_arm : Node3D
#@export var bullet_scene : PackedScene
#@export var animated_gun : AnimationPlayer
@export_category("Setup")
#@export var camera : Camera3D
@export var health = 10
@export var anim_player : AnimationPlayer
@export var state_machine : StateMachine

@onready var weapon_loc = $Remy/Armature/Skeleton3D/HandAttach/Node3D/Sword/SwordArea/CollisionShape3D
var mat2 = preload("res://IsoTest/Material/enemy_placeholder_hurt.tres")

@export var timer : Timer


const SPEED = 7.0
const ACCEL = 9.0
const PUSHBACK = 8.0
const JUMP_VELOCITY = 5.0

var sword_damage = 5

var item_score

var input_dir := Vector2(0,0)

func _ready() -> void:
	var states : Array[State] = [PlayerIdleState.new(self), PlayerMovementState.new(self), PlayerAttackState.new(self), PlayerBlockState.new(self)]
	
	state_machine.start_machine(states)

func _physics_process(delta: float) -> void:
	$TextHP.text = "Health: " + str(health)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

		#anim_player.play("QUICK_ATTACK")
		#if !animated_gun.is_playing():
			#animated_gun.play("recoil")
			#shoot()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	input_dir = Input.get_vector("left", "right", "up" , "down")
	#var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	##Transform basis: [X: (1.0, 0.0, 0.0), Y: (0.0, 1.0, 0.0), Z: (0.0, 0.0, 1.0)]
	##var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
#
	#var target_velocity = direction * SPEED
	#if direction:
		#velocity = velocity.lerp(target_velocity, ACCEL * delta)
		##velocity = direction * SPEED
		##anim_player.play("RUN")
	#else:
		##anim_player.play("IDLE")
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
		
#	---------
	# Get mouse position in screen coordinates
	var mouse_pos = get_viewport().get_mouse_position()

	# Project mouse position onto the character's y-level plane (e.g., y = global_position.y)
	#var from = camera.project_ray_origin(mouse_pos)
	#var ray_dir = camera.project_ray_normal(mouse_pos)
	#
	# Calculate intersection with the plane at the character's y position
	#var plane_normal = Vector3.UP  # Plane normal (y-axis)
	#var plane_origin = Vector3(0, global_position.y, 0)  # Plane at character's y-level
	#var t = plane_normal.dot(plane_origin - from) / plane_normal.dot(ray_dir)
	#var target_point = from + ray_dir * t

	# Calculate direction to the target point
	#direction = (target_point - global_position).normalized()

	# Compute yaw (y-axis rotation) using atan2
	#var yaw = atan2(direction.x, direction.z)

	# Apply rotation only on y-axis (full spectrum: -π to π)
	#gun_arm.rotation = Vector3(0, yaw, 0)
	#$MeshInstance3D.rotation = Vector3(1.5, yaw, 0)
	#$Remy.rotation = Vector3(0, yaw, 0)

	# Optional: Smooth rotation using lerp
	# rotation.y = lerp_angle(rotation.y, yaw, 5.0 * delta)
	move_and_slide()
	
#func shoot () -> void:
	#var bullet = bullet_scene.instantiate()
	##bullet.position = gun_arm.get_node('BulletSpawn').global_position
	##bullet.rotation = gun_arm.global_rotation  # Use pivot's rotation, not player's
	#get_tree().current_scene.add_child(bullet)
	#bullet.transform = gun_arm.get_node('BulletSpawn').global_transform
	#bullet.velocity = -bullet.transform.basis.z * bullet.muzzle_velocity
	
func hit(damage, dir):
	health -= damage

func item_absorbed():
	pass
	
func enable_sword_collision():
	weapon_loc.disabled = false
	
func disable_sword_collision():
	weapon_loc.disabled = true

#func _on_sword_area_area_entered(area: Area3D) -> void:
	#print("Signal from player", area)
	#pass # Replace with function body.

func _on_sword_area_body_entered(body: Node3D) -> void:
	if body.has_method("this_thing_take_damage"):
		body.this_thing_take_damage(sword_damage)
		
func player_take_damage(dmg):
	timer.start()
	print("ouchie")
	var red = Color(1.0, 0.0, 0.0, 1.0)
	$Remy/Armature/Skeleton3D/Body.set_surface_override_material(0, mat2)
	print("taking damage")
	#curr_health -= dmg
	#curr_health = clampf(curr_health, 0, MAX_HEALTH)
	#if curr_health <= 0:
		#print("ME DEAD")
