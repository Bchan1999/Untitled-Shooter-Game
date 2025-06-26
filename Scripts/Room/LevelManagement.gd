extends Node2D

var room1 = preload("res://Scenes/room_layout_1.tscn")
var room2 = preload("res://Scenes/room_layout_2.tscn")
var curr_room_str
@export var camera = Camera2D
@export var player = CharacterBody2D

func _ready() -> void:
	SignalBus.room_change.connect(room_change)
	room_change("room1")

func room_change(target_room):
	print("called level mange")
	print(get_tree().current_scene)
	var curr_room : Node2D 

	if target_room == curr_room_str:
		push_error("Already in current curr_room")
	elif target_room == "room1":
		curr_room = room1.instantiate()
		add_child(curr_room)
		curr_room_str = "room1"
	elif target_room == "room2":
		curr_room = room2.instantiate()
		add_child(curr_room)
		curr_room_str = "room2"
	
	spawn_player(curr_room)
	
func spawn_player(curr_room):
	print(curr_room.get_spawn_point())
	player.global_position = curr_room.get_spawn_point()
	camera.set_target_pos(curr_room.get_spawn_point())
		

		
