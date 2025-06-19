extends Node

signal bullet_hit(target) # Signal for when a bullet hits something

func emit_bullet_hit(target):
	emit_signal("bullet_hit", target)
