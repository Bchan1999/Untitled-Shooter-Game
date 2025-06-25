extends Node

signal bullet_hit(target) # Signal for when a bullet hits something

signal package_pickup()

func emit_bullet_hit(target):
	emit_signal("bullet_hit", target)
	
func emit_package_pick_up():
	emit_signal("package_pickup")
	
