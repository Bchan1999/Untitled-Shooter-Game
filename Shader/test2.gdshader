shader_type canvas_item;

uniform float time_speed = 0.1;
uniform float glitch_strength = 0.6;
uniform float chroma_offset = 0.5;
uniform sampler2D noise_texture;

void fragment() {
    float time = TIME * time_speed;

    // Base UV and noise sampling
    vec2 uv = UV;

    // Vertical jitter
    float y_offset = (fract(sin(dot(vec2(time, uv.y), vec2(12.9898,78.233))) * 43758.5453));
    uv.y += (y_offset - 0.5) * 0.02 * glitch_strength;

    // Horizontal scanline jitter
    float glitch = texture(noise_texture, vec2(time * 0.1, uv.y * 4.0)).r;
    uv.x += (glitch - 0.5) * 0.05 * glitch_strength;

    // RGB split (Chromatic Aberration)
    vec4 col_r = texture(TEXTURE, uv + vec2(chroma_offset * 0.001, 0.0));
    vec4 col_g = texture(TEXTURE, uv);
    vec4 col_b = texture(TEXTURE, uv - vec2(chroma_offset * 0.001, 0.0));

    vec4 final_color = vec4(col_r.r, col_g.g, col_b.b, col_g.a);

    // Intermittent flicker effect
    float flicker = step(0.9, fract(sin(time * 10.0) * 43758.5453));
    final_color.rgb *= mix(1.0, 0.2, flicker);

    COLOR = final_color;
}
