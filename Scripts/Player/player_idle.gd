extends PlayerState
class_name PlayerIdleState

@export var animation : String = "IDLE"
static var state_name = "PlayerIdleState"

func get_state_name() -> String: 
	return state_name

func physics_update(delta: float) -> void:
	if player.input_dir != Vector2(0,0):
		#state_machine.transition("PlayerMovementState")
		Transitioned.emit(self, "movement")
		
	if Input.is_action_just_pressed("shoot"):
		Transitioned.emit(self, "PickAxeSwing")
		
	if Input.is_action_pressed("block"):
		Transitioned.emit(self, "Block")
		
	
func exit():
	pass
	#print("im doing something before exiting")

func enter():
	anim_player.play(animation)
