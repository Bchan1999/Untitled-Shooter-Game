extends Node

@onready var player = get_node("/root/Main/Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		#print(player)
		pass
	else:
		assert(false, "Please assign a player to this node")
	
func spawn(spawn_point, room):
	var str = "/root/Main/LevelTransition/" + room.get_class_name() + "/" + spawn_point
	#var path = get_node("/Main/LevelTransition/" + room.get_class_name() + "/" + spawn_point)
	var path = get_node("/root/Main/LevelTransition/" + room.get_class_name() + "/" + spawn_point)
	#var newPAth = get_node("/root/SignalBus")
	#print("Path pos: " , path.global_position)
	player.global_position = path.global_position
	#print("Player pos: " , player.global_position)
	#print("Path pos: " , path.global_position)
	#print("bitch")
	
#func room_change(room, spawn_point, level_self : Node3D):
	#spawn(spawn_point, room)
	#pass
