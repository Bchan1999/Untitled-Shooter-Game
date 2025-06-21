shader_type canvas_item;

uniform float rotation_speed : hint_range(0.0, 10.0) = 2.0;
uniform vec4 reticle_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float inner_circle_size : hint_range(0.01, 0.2) = 0.05;
uniform float outer_circle_size : hint_range(0.01, 0.3) = 0.08;
uniform float circle_thickness : hint_range(0.001, 0.05) = 0.01;
uniform float center_dot_size : hint_range(0.001, 0.02) = 0.005;

void fragment() {
    vec2 uv = UV - vec2(0.5); // Center UV coordinates
    float time = TIME * rotation_speed;
    
    // Rotate UV coordinates
    float angle = time;
    vec2 rotated_uv = vec2(
        uv.x * cos(angle) - uv.y * sin(angle),
        uv.x * sin(angle) + uv.y * cos(angle)
    );
    
    // Calculate distance from center
    float dist = length(rotated_uv);
    
    // Inner circle with segments
    float inner_ring = smoothstep(inner_circle_size - circle_thickness, inner_circle_size, dist) * 
                      smoothstep(inner_circle_size + circle_thickness, inner_circle_size, dist);
    float inner_segment = abs(sin(atan(rotated_uv.y, rotated_uv.x) * 4.0));
    float inner_reticle = inner_ring * (1.0 - inner_segment);
    
    // Outer circle with segments
    float outer_ring = smoothstep(outer_circle_size - circle_thickness, outer_circle_size, dist) * 
                      smoothstep(outer_circle_size + circle_thickness, outer_circle_size, dist);
    float outer_segment = abs(sin(atan(rotated_uv.y, rotated_uv.x) * 4.0));
    float outer_reticle = outer_ring * (1.0 - outer_segment);
    
    // Center dot
    float center_dot = smoothstep(center_dot_size, center_dot_size - 0.001, dist);
    
    // Combine reticles
    float final_reticle = max(max(inner_reticle, outer_reticle), center_dot);
    
    // Apply color and alpha
    COLOR = vec4(reticle_color.rgb, final_reticle * reticle_color.a);
}