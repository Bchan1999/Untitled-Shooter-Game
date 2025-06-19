extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var pickup_flag = false
var num_of_packages: int = 0

@export var move_speed := 200
@export var bullet_scene : PackedScene
@export var item_detect : Area2D
@export var arm : Node2D

func _physics_process(delta):
	var dir = Input.get_vector("left", "right", "up" , "down")
	velocity = dir * move_speed
	
	var mouse_pos = get_local_mouse_position()
	var rotate = atan2(mouse_pos.y, mouse_pos.x)
	arm.global_rotation = lerp_angle(arm.global_rotation, rotate, 0.2)

	move_and_slide()

	if Input.is_action_just_pressed("shoot"):
		shoot()
		
	if Input.is_action_just_pressed("pickup") and pickup_flag == true:
		pickup()
		
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = arm.get_marker2d_global_position()
	bullet.rotation = arm.global_rotation  # Use pivot's rotation, not player's
	get_tree().current_scene.add_child(bullet)
	
func pickup():
	num_of_packages = num_of_packages + 1
	SignalBus.emit_package_pick_up()
	print("I picked it up!")
	print("I am carrying ", num_of_packages, " pacakges")
	pass

func _on_item_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("package"):
		print("I CAN PICK THIS SHIT UP!")
		pickup_flag = true

func _on_item_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("package"):
		print("AH FUCK ITS GONEEEEEEE")
		pickup_flag = false
