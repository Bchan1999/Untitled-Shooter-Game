shader_type canvas_item;

group_uniforms Pixelation;
uniform float pixel_size : hint_range(1.0, 20.0, 1.0) = 8.0; // Size of pixelated blocks
uniform float color_count : hint_range(2.0, 32.0, 1.0) = 8.0; // Number of colors in palette

group_uniforms FilmGrain;
uniform float grain_intensity : hint_range(0.0, 0.5, 0.01) = 0.1; // Strength of grain
uniform float scratch_intensity : hint_range(0.0, 0.5, 0.01) = 0.05; // Strength of scratches
uniform float scratch_speed : hint_range(0.0, 10.0, 0.1) = 2.0; // Speed of scratch movement
uniform vec3 tint : source_color = vec3(0.76, 0.52, 0.3); // Sepia tint for film effect

uniform sampler2D Source : hint_screen_texture, filter_linear_mipmap, repeat_disable;

// Simple noise function for grain
float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 uv = UV;

    // Pixelation: Snap UV to a grid for blocky effect
    vec2 pixelated_uv = floor(uv * textureSize(Source, 0) / pixel_size) * pixel_size / textureSize(Source, 0);
    vec4 color = texture(Source, pixelated_uv);

    // Reduce color palette
    color.rgb = floor(color.rgb * color_count) / color_count;

    // Film grain: Add animated noise
    float noise = random(uv + TIME * 0.1) * grain_intensity;
    color.rgb += vec3(noise);

    // Film scratches: Thin, vertical lines moving over time
    float scratch = 0.0;
    float scratch_pos = random(vec2(floor(TIME * scratch_speed), 0.0));
    if (abs(uv.x - scratch_pos) < 0.002) {
        scratch = scratch_intensity * (0.5 + 0.5 * sin(TIME * scratch_speed));
    }
    color.rgb += vec3(scratch);

    // Apply sepia tint
    color.rgb = mix(color.rgb, tint * dot(color.rgb, vec3(0.299, 0.587, 0.114)), 0.5);

    // Ensure alpha is preserved
    COLOR = vec4(color.rgb, color.a);
}