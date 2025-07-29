extends PlayerState
class_name PlayerMovementState

@export var animation : String = "RUN"
static var state_name = "PlayerMovementState"

const SPEED = 7.0
const ACCEL = 9.0
const PUSHBACK = 8.0
const JUMP_VELOCITY = 5.0

func get_state_name() -> String:
	return state_name
	
func physics_update(delta: float) -> void:
	anim_player.play(animation)

	var direction := Vector3(player.input_dir.x, 0, player.input_dir.y).normalized()
	var angleCoord = Vector2(player.input_dir.x, -player.input_dir.y)
	var angle = angleCoord.angle()
	print(angle)
	

	var target_velocity = direction * SPEED
	if direction:
		player.velocity = player.velocity.lerp(target_velocity, ACCEL * delta)
		player.rotation.y = angle + 1.57079637050629
		#velocity = direction * SPEED
		#anim_player.play("RUN")
	else:
		#anim_player.play("IDLE")
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
		
	if player.velocity == Vector3(0,0,0):
		state_machine.transition("PlayerIdleState")
