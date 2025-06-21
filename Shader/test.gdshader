shader_type canvas_item;

uniform float speed : hint_range(0.1, 5.0) = 10.0;
uniform float scale : hint_range(0.1, 10.0) = 10.0;
uniform vec3 color_shift = vec3(0.2, 0.1, 0.9);

void fragment() {
    vec2 uv = UV * scale;
    float t = TIME * speed;
    
    float v1 = sin(uv.x + t);
    float v2 = sin(uv.y + t * 0.7);
    float v3 = sin(uv.x + uv.y + t * 0.3);
    float v4 = sin(sqrt(uv.x * uv.x + uv.y * uv.y) + t);
    
    float col = v1 + v2 + v3 + v4;
    col = sin(col * 1.5) * 0.5 + 0.5;
    
    COLOR.rgb = vec3(
        sin(col + color_shift.r * 6.28) * 0.5 + 0.5,
        sin(col + color_shift.g * 6.28) * 0.5 + 0.5,
        sin(col + color_shift.b * 6.28) * 0.5 + 0.5
    );
    COLOR.a = 1.0;
}//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
