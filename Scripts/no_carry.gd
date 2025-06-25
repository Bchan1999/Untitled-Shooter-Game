extends State
class_name PlayerNoCarry

@export var player: CharacterBody2D
@export var anim : AnimationPlayer
var pickup_flag = false

func Enter():
	anim.play("run_right")
	
func Update(delta: float):
	if Input.is_action_pressed("right"):
		anim.play("run_right")
		#$AnimatedSprite2D.flip_h = false
		#$IdleCrate.flip_h = false
	if Input.is_action_pressed("left"):
		anim.play("run_left")
		
	if Input.is_action_just_pressed("pickup") and pickup_flag == true:
		pickup()
		
func pickup():
	SignalBus.emit_package_pick_up()
	Transitioned.emit(self, "carry")
	print("I picked it up!")
	pass

func _on_item_detect_area_entered(area: Area2D) -> void:
	if area.is_in_group("package"):
		print("I CAN PICK THIS SHIT UP!")
		pickup_flag = true

func _on_item_detect_area_exited(area: Area2D) -> void:
	if area.is_in_group("package"):
		print("AH FUCK ITS GONEEEEEEE")
		pickup_flag = false
