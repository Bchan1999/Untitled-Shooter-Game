extends State
class_name PlayerTurret

@export var anim_legs : AnimationPlayer
@export var anim_head : AnimationPlayer
var pickup_flag = false

func Enter():
	anim_legs.play("idle")
	
func Update(delta: float):
	if Input.is_action_just_pressed("shoot"):
		anim_head.play("shoot")
	elif anim_head.current_animation != "shoot":
		anim_head.play("idle")
	
		#
	#if Input.is_action_just_pressed("left") == false && Input.is_action_just_pressed("right") == false:
		#anim.play("idle_right")
		#
	#if Input.is_action_pressed("right"):
		#anim.play("run")
		##$AnimatedSprite2D.flip_h = false
		##$IdleCrate.flip_h = false
	#if Input.is_action_pressed("left"):
		#anim.play("run")
		#
#
	#if Input.is_action_just_pressed("pickup") and pickup_flag == true:
		#pickup()
		
#func pickup():
	#SignalBus.emit_package_pick_up()
	#Transitioned.emit(self, "carry")
	#print("I picked it up!")
	#pass
#
#func _on_item_detect_area_entered(area: Area2D) -> void:
	#if area.is_in_group("package"):
		#print("I CAN PICK THIS SHIT UP!")
		#pickup_flag = true
#
#func _on_item_detect_area_exited(area: Area2D) -> void:
	#if area.is_in_group("package"):
		#print("AH FUCK ITS GONEEEEEEE")
		#pickup_flag = false
