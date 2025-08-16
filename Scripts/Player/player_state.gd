extends State
class_name PlayerState

@export var player: PlayerController  # Still export if you want inspector override
@export var anim_player: AnimationPlayer
@export var state_machine: StateMachine
@export var label: Label



func _ready():  # Note: _ready() with underscore!
	# If not set in inspector, fetch dynamically
	if player == null:
		player = get_node("/root/Main/Player")  # Or find_owner() if Player is the scene root
	if anim_player == null:
		anim_player = player.get_node("CapsuleAnimation")  # Assumes AnimationPlayer is child of Player
	if state_machine == null:
		state_machine = player.get_node("StateMachine")  # Since states are children of StateMachine
	if label == null:
		label = player.get_node("PlayerState/StaminaLabel")

	
	

	

	
		
