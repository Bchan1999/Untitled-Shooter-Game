extends StaticBody2D

func _ready():
	SignalBus.bullet_hit.connect(_on_bullet_hit)

func _on_bullet_hit(target: Variant) -> void:
	if target == self:
		print('me shrine been hit')
