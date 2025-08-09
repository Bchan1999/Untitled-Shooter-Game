extends PlayerState
class_name PlayerBlockState

@export var animation : String = "BLOCK"
static var state_name = "PlayerBlockState"

func get_state_name() -> String: 
	return state_name

func physics_update(delta: float) -> void:
	anim_player.play(animation)
	if Input.is_action_just_released("block"):
		state_machine.transition("PlayerIdleState")
		
func Exit():
	print("im doing something before exiting")
