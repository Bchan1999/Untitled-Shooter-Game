extends Node3D
class_name Level2Test

@onready var door_1_location = load("res://Scenes/LevelTest/level_1_test.tscn")
var door_1_exit_spawn = "Spawn1"
var test

func _ready() -> void:
	#print(door_1_location.can_instantiate())
	test = door_1_location.instantiate()

#func _process(delta: float) -> void:
	#print(test)

func get_class_name():
	return "Level2Test"

func _on_exit_1_body_entered(body: Node3D) -> void:
	if body.is_in_group("door"):
		#print(test)
		print("come on in")
		#print(door_location)
		SignalBus.room_change.emit(test, door_1_exit_spawn, self)
