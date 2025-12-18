shader_type canvas_item;
// Removed skip_vertex_transform unless you plan to write custom vertex math
render_mode unshaded;

uniform vec2 target_resolution = vec2(320.0, 180.0);
uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

void fragment() {
    // 1. Calculate the grid based on target resolution
    // We use SCREEN_UV to get the screen coordinates
    vec2 grid_uv = floor(SCREEN_UV * target_resolution) / target_resolution;
    
    // 2. Sample the screen texture using the snapped coordinates
    vec4 color = texture(screen_texture, grid_uv);
    
    COLOR = color;
}