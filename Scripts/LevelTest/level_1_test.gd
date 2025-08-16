extends Node3D
class_name Level1Test

@onready var door_1_location = load("res://Scenes/LevelTest/level_2_test.tscn")
@onready var door_2_location = load("res://Scenes/LevelTest/level_3_test.tscn")
var door_1_exit_spawn = "Spawn1"
var door_2_exit_spawn = "Spawn1"

func get_class_name():
	return "Level1Test"

func _on_exit_1_body_entered(body: Node3D) -> void:
	print("level1 body enter: ", body)
	if body.is_in_group("door"):
		var door_location = door_1_location.instantiate()
		SignalBus.room_change.emit(door_location, door_1_exit_spawn, self)


func _on_exit_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("door"):
		var door_location = door_2_location.instantiate()
		SignalBus.room_change.emit(door_location, door_2_exit_spawn, self)
