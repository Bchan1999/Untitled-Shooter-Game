shader_type canvas_item;

// Uniforms for customization
uniform float outline_thickness : hint_range(0.0, 0.01) = 0.002;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float color_levels : hint_range(1.0, 16.0) = 8.0;
uniform float halftone_scale : hint_range(0.0, 10.0) = 2.0;
uniform float halftone_strength : hint_range(0.0, 1.0) = 0.3;

// Sobel edge detection for outlines
float sobel_edge(vec2 uv, sampler2D tex, vec2 texel_size) {
    float sobel_x[9] = float[9](-1.0, 0.0, 1.0, -2.0, 0.0, 2.0, -1.0, 0.0, 1.0);
    float sobel_y[9] = float[9](-1.0, -2.0, -1.0, 0.0, 0.0, 0.0, 1.0, 2.0, 1.0);
    vec2 offsets[9] = vec2[9](
        vec2(-1.0, -1.0), vec2(0.0, -1.0), vec2(1.0, -1.0),
        vec2(-1.0, 0.0), vec2(0.0, 0.0), vec2(1.0, 0.0),
        vec2(-1.0, 1.0), vec2(0.0, 1.0), vec2(1.0, 1.0)
    );
    
    float gx = 0.0;
    float gy = 0.0;
    for (int i = 0; i < 9; i++) {
        vec4 sample = texture(tex, uv + offsets[i] * texel_size * outline_thickness);
        float luminance = dot(sample.rgb, vec3(0.299, 0.587, 0.114));
        gx += sobel_x[i] * luminance;
        gy += sobel_y[i] * luminance;
    }
    return sqrt(gx * gx + gy * gy);
}

// Halftone pattern
float halftone(vec2 uv, float scale, float intensity) {
    vec2 grid = uv * scale;
    vec2 grid_floor = floor(grid);
    vec2 grid_frac = fract(grid);
    float circle = length(grid_frac - 0.5);
    float threshold = 0.5 * (1.0 - intensity);
    return smoothstep(threshold - 0.1, threshold + 0.1, circle);
}

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    
    // Edge detection for outlines
    float edge = sobel_edge(UV, TEXTURE, TEXTURE_PIXEL_SIZE);
    float outline = step(0.1, edge);
    
    // Quantize colors for cel-shading
    vec3 quantized_color = floor(color.rgb * color_levels) / color_levels;
    
    // Apply halftone effect
    float halftone_value = halftone(UV, halftone_scale, halftone_strength);
    vec3 final_color = mix(quantized_color, quantized_color * halftone_value, halftone_strength);
    
    // Combine outline and color
    vec4 output_color = mix(vec4(final_color, color.a), outline_color, outline);
    
    COLOR = output_color;
}