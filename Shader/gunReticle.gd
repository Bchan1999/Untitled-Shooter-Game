extends ColorRect

func _ready():
	# Ensure the ColorRect uses the shader material
	var material = ShaderMaterial.new()
	material.shader = load("res://spinning_reticle.gdshader")
	self.material = material
	
	# Optional: Set initial shader parameters
	material.set_shader_parameter("rotation_speed", 2.0)
	material.set_shader_parameter("reticle_color", Color(1.0, 0.0, 0.0, 1.0))
	material.set_shader_parameter("reticle_size", 0.05)
	material.set_shader_parameter("thickness", 0.01)
