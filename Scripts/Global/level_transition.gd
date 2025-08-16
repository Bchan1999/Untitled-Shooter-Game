extends Node3D
var any_object
var object_state_transition
var get_exit_level
var spawn_level
var check_if_obj_can_transition

@export var curr_level : Node3D

func _ready() -> void:
	if curr_level:
		print(curr_level)
		pass
	else:
		assert(false, "Please assign a starting level to this node")
	SignalBus.room_change.connect(level_spawn)
	
func level_spawn(room, spawn_point, level_self : Node3D):
	#print("Room: " , room)
	#print("Spawn point: " , spawn_point)
	
	Spawnner.spawnAway()
	await wait(0.01)
	level_self.queue_free()
	self.add_child(room)
	Spawnner.spawnRoom(spawn_point, room)
	pass
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
