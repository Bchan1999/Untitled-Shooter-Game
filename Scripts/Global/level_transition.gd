extends Node3D

var any_object
var object_state_transition
var get_exit_level
var spawn_level
var check_if_obj_can_transition

@export var curr_level : LevelType

func _ready() -> void:
	if curr_level:
		pass
	else:
		push_error("Please assign a starting level to this node")
