extends Node3D

var MAX_HEALTH = 3
var curr_health

@onready var pebble_scene = load("res://Scenes/pebble.tscn")
var mat2 = preload("res://Material/enemy_placeholder_hurt.tres")
var mat1 = preload("res://Material/bomb_white.tres")

func _ready():
	curr_health = MAX_HEALTH 

func give_me_damage(dmg):
	print('YOU HIT ME')
	curr_health -= dmg
	curr_health = clampf(curr_health, 0, MAX_HEALTH)
	if curr_health <= 0:
		#$Bomb.set_surface_override_material(0, mat2)
		$bomb_timer.start()
		
		var tween = create_tween() 
		tween.tween_property($Bomb, "surface_material_override/0", mat2, 0.2)
		tween.tween_property($Bomb, "surface_material_override/0", mat1, 0.2)
		tween.set_loops(5)
		
		
func spawn_pebble():
	var pebble = pebble_scene.instantiate()
	#bullet.position = gun_arm.get_node('BulletSpawn').global_position
	#bullet.rotation = gun_arm.global_rotation  # Use pivot's rotation, not player's
	get_tree().current_scene.add_child(pebble)
	pebble.global_position = $Marker3D.global_position


func _on_timer_timeout() -> void:
	print("I BLOWWWW")
	var tween = create_tween()
	tween.tween_callback($Bomb.queue_free)
	tween.tween_property($ring, "scale",  Vector3(10, 1, 10), 0.5)
	tween.tween_callback(self.spawn_pebble)
	tween.tween_callback(self.queue_free)
	#self.queue_free()
	pass # Replace with function body.
