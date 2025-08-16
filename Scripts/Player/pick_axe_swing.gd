extends PlayerState
class_name PlayerPickaxeSwingState

@export var animation : String = "AXE"
static var state_name = "PlayerPickaxeSwingState"
@export var rockHit : AudioStreamPlayer

func get_state_name() -> String:
	return state_name
	
func enter():
	anim_player.play(animation)

func physics_update(delta: float) -> void:
	if (!anim_player.is_playing()):
		Transitioned.emit(self, "Idle")
		
func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Body: ", body)
	if(body.is_in_group('rock')):
		print('give rock damage ')
		rockHit.play()
		if (body.has_method('give_me_damage')):
			player.stamina_reduce(1)
			body.give_me_damage(3)
