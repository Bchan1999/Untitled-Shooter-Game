extends Node3D

var MAX_HEALTH = 9
var curr_health

@onready var pebble_scene = load("res://Scenes/pebble.tscn")

func _ready():
	curr_health = MAX_HEALTH 

func give_me_damage(dmg):
	print('YOU HIT ME')
	curr_health -= dmg
	curr_health = clampf(curr_health, 0, MAX_HEALTH)
	if curr_health <= 0:
		spawn_pebble()
		self.queue_free()
		
func spawn_pebble():
	var pebble = pebble_scene.instantiate()
	#bullet.position = gun_arm.get_node('BulletSpawn').global_position
	#bullet.rotation = gun_arm.global_rotation  # Use pivot's rotation, not player's
	get_tree().current_scene.add_child(pebble)
	pebble.global_position = $Marker3D.global_position
	
