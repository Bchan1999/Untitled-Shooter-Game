extends State
class_name PlayerCarry

@export var player: CharacterBody2D
@export var anim : AnimationPlayer

func Enter():
	anim.play("run_with_package_right")
	
func Update(delta: float):
	if Input.is_action_pressed("right"):
		anim.play("run_with_package_right")
		#$AnimatedSprite2D.flip_h = false
		#$IdleCrate.flip_h = false
	if Input.is_action_pressed("left"):
		anim.play("run_with_package_left")

	
