extends Node3D
class_name Level1Test

@export var door_1_location : PackedScene
var door_1_exit_spawn = "Spawn1"

func get_class_name():
	return "Level1Test"

func _on_exit_1_body_entered(body: Node3D) -> void:
	if body.is_in_group("door"):
		var door_location = door_1_location.instantiate()
		print("come on in")
		print(door_location)
		SignalBus.room_change.emit(door_location, door_1_exit_spawn, self)
