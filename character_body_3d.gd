extends CharacterBody3D

@export var camera : Camera3D
@export var gun_arm : Node3D
@export var bullet_scene : PackedScene
@export var health = 10

const SPEED = 10.0
const ACCEL = 9.0
const PUSHBACK = 8.0
const JUMP_VELOCITY = 5.0


func _physics_process(delta: float) -> void:
	$TextHP.text = "Health: " + str(health)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("shoot"):
		shoot()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up" , "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
#	---------
	# Get mouse position in screen coordinates
	var mouse_pos = get_viewport().get_mouse_position()

	# Project mouse position onto the character's y-level plane (e.g., y = global_position.y)
	var from = camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos)
	
	# Calculate intersection with the plane at the character's y position
	var plane_normal = Vector3.UP  # Plane normal (y-axis)
	var plane_origin = Vector3(0, global_position.y, 0)  # Plane at character's y-level
	var t = plane_normal.dot(plane_origin - from) / plane_normal.dot(ray_dir)
	var target_point = from + ray_dir * t

	# Calculate direction to the target point
	direction = (target_point - global_position).normalized()

	# Compute yaw (y-axis rotation) using atan2
	var yaw = atan2(direction.x, direction.z)

	# Apply rotation only on y-axis (full spectrum: -π to π)
	gun_arm.rotation = Vector3(0, yaw, 0)

	# Optional: Smooth rotation using lerp
	# rotation.y = lerp_angle(rotation.y, yaw, 5.0 * delta)

	move_and_slide()
	
func shoot () -> void:
	var bullet = bullet_scene.instantiate()
	#bullet.position = gun_arm.get_node('BulletSpawn').global_position
	#bullet.rotation = gun_arm.global_rotation  # Use pivot's rotation, not player's
	get_tree().current_scene.add_child(bullet)
	bullet.transform = gun_arm.get_node('BulletSpawn').global_transform
	bullet.velocity = -bullet.transform.basis.z * bullet.muzzle_velocity
	
func hit(damage, dir):
	health -= damage
	
