extends PlayerState
class_name PlayerPickaxeSwingState

@export var animation : String = "AXE"
static var state_name = "PlayerPickaxeSwingState"

const DAMAGE = 5.0

func get_state_name() -> String:
	return state_name
	
func enter():
	anim_player.play(animation)
	
func physics_update(delta: float) -> void:
	if (!anim_player.is_playing()):
		state_machine.transition("PlayerIdleState")
		
	#if player.input_dir != Vector2(0,0):
		#state_machine.transition("PlayerMovementState")
	
