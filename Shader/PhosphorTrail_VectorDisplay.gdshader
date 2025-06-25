shader_type canvas_item;

group_uniforms Phosphor;
uniform float phosphor_decay : hint_range(0.0, 1.0, 0.01) = 0.85; // How quickly trails fade
uniform float phosphor_intensity : hint_range(0.0, 2.0, 0.01) = 1.0; // Brightness of trails

group_uniforms Vector;
uniform float edge_intensity : hint_range(0.0, 5.0, 0.01) = 2.0; // Strength of glowing edges
uniform vec3 edge_color : source_color = vec3(0.0, 1.0, 0.2); // Neon green for vector lines
uniform float flicker_speed : hint_range(0.0, 10.0, 0.1) = 2.0; // Speed of flicker effect
uniform float wobble_amount : hint_range(0.0, 0.01, 0.0001) = 0.002; // Amount of UV wobble

uniform sampler2D Source : hint_screen_texture, filter_linear_mipmap, repeat_disable;
uniform sampler2D PreviousFrame : hint_default_black; // Texture to store previous frame

// Edge detection using Sobel filter
float sobel_edge(vec2 uv, sampler2D tex, vec2 texel_size) {
    vec3 s00 = texture(tex, uv + vec2(-texel_size.x, -texel_size.y)).rgb;
    vec3 s10 = texture(tex, uv + vec2(-texel_size.x, 0.0)).rgb;
    vec3 s20 = texture(tex, uv + vec2(-texel_size.x, texel_size.y)).rgb;
    vec3 s01 = texture(tex, uv + vec2(0.0, -texel_size.y)).rgb;
    vec3 s21 = texture(tex, uv + vec2(0.0, texel_size.y)).rgb;
    vec3 s02 = texture(tex, uv + vec2(texel_size.x, -texel_size.y)).rgb;
    vec3 s12 = texture(tex, uv + vec2(texel_size.x, 0.0)).rgb;
    vec3 s22 = texture(tex, uv + vec2(texel_size.x, texel_size.y)).rgb;

    vec3 dx = (s00 + 2.0 * s10 + s20) - (s02 + 2.0 * s12 + s22);
    vec3 dy = (s00 + 2.0 * s01 + s02) - (s20 + 2.0 * s21 + s22);
    return length(dx) + length(dy);
}

void fragment() {
    vec2 uv = UV;
    
    // Apply subtle wobble for vector display effect
    uv += sin(TIME * 5.0 + uv.y * 10.0) * wobble_amount;

    // Get texel size for edge detection
    vec2 texel_size = 1.0 / vec2(textureSize(Source, 0));

    // Sample current frame
    vec4 current = texture(Source, uv);

    // Sample previous frame for phosphor trail
    vec4 prev = texture(PreviousFrame, uv);
    
    // Calculate edges for vector display
    float edge = sobel_edge(uv, Source, texel_size);
    vec3 vector_effect = edge_color * edge * edge_intensity;

    // Combine current frame with phosphor trail
    vec3 phosphor = prev.rgb * phosphor_decay + current.rgb * (1.0 - phosphor_decay);
    phosphor *= phosphor_intensity;

    // Add flicker effect
    float flicker = 1.0 + 0.1 * sin(TIME * flicker_speed);

    // Final color: blend vector lines with phosphor trails
    vec3 final_color = mix(phosphor, vector_effect, 0.5) * flicker;
    
    COLOR = vec4(final_color, current.a);
}