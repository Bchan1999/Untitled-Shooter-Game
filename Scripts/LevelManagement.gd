extends Node2D

var room1 = preload("res://Scenes/room_layout_1.tscn")
var room2 = preload("res://Scenes/room_layout_2.tscn")
var curr_room
@onready var camera = get_node("../Camera2D")

func _ready() -> void:
	room_change("room1")

func room_change(target_room):
	print("called level mange")
	print(get_tree().current_scene)
	if target_room == "room1":
		print("room stuff")
		var test : Node2D = room1.instantiate()
		add_child(test)
		print(test.get_parent())
		curr_room = "room1"
		
func spawn_player():
	pass
