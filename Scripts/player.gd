extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var move_speed := 200
@export var bullet_scene : PackedScene


func _physics_process(delta):
	var dir = Input.get_vector("left", "right", "up" , "down")
	velocity = dir * move_speed
	
	var mouse_pos = get_local_mouse_position()
	var rotate = atan2(mouse_pos.y, mouse_pos.x)
	$pivot.global_rotation = lerp_angle($pivot.global_rotation, rotate, 0.2)

	move_and_slide()


	if Input.is_action_just_pressed("shoot"):
		shoot()
		

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = $pivot/Marker2D.global_position
	bullet.rotation = $pivot.global_rotation  # Use pivot's rotation, not player's
	get_tree().current_scene.add_child(bullet)
