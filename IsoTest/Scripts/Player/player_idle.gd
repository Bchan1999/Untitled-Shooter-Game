extends PlayerState
class_name PlayerIdleState

@export var animation : String = "IDLE"
static var state_name = "PlayerIdleState"

func get_state_name() -> String: 
	return state_name

func physics_update(delta: float) -> void:
	anim_player.play(animation)
	if player.input_dir != Vector2(0,0):
		state_machine.transition("PlayerMovementState")
		
	if Input.is_action_pressed("shoot"):
		state_machine.transition("PlayerAttackState")
	
func Exit():
	print("im doing something before exiting")

	
