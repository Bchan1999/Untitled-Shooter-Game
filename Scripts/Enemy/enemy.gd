extends CharacterBody2D

@export var health: Node2D
@export var bullet_damage : int = 30


func _ready() -> void:
	SignalBus.bullet_hit.connect(_on_bullet_hit)
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func _on_bullet_hit(target: Variant) -> void:
	if target == self:	
		print('me enemy been hit')
		health.take_damage(bullet_damage)
		
func _on_health_died() -> void:
	self.queue_free()
