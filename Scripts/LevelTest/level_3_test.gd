extends Node3D
class_name Level3Test

@onready var door_1_location = load("res://Scenes/LevelTest/level_1_test.tscn")
var door_1_exit_spawn = "Spawn1"

func get_class_name():
	return "Level3Test"

func _on_exit_1_body_entered(body: Node3D) -> void:
	if body.is_in_group("door"):
		var door_location = door_1_location.instantiate()
		SignalBus.room_change.emit(door_location, door_1_exit_spawn, self)
