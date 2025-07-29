extends State
class_name PlayerState

@export var player: PlayerController
@export var anim_player: AnimationPlayer
@export var state_machine: StateMachine

func _init(player_controller: PlayerController) -> void:
	player = player_controller
	anim_player = player.anim_player
	state_machine = player.state_machine
	
