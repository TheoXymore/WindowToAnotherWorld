shader_type canvas_item;

uniform vec2 window_center;
uniform vec2 window_size;

uniform sampler2D screen_texture: hint_screen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

bool is_in_rect(vec2 pixel){
	float left = window_center.x - window_size.x / 2.0;
    float right = window_center.x + window_size.x / 2.0;
    float top = window_center.y - window_size.y / 2.0;
    float bottom = window_center.y + window_size.y / 2.0;
	
	if (pixel.x < (window_center.x - window_size.x /2.0)) return false;
	if (pixel.y < (window_center.y - window_size.y /2.0)) return false;
	if (pixel.x > (window_center.x + window_size.x /2.0)) return false;
	if (pixel.x > (window_center.x + window_size.x /2.0)) return false;
	return true;
}

void fragment() {
	vec2 pixel = FRAGCOORD.xy;	
	
	float left = window_center.x - window_size.x / 2.0;
    float right = window_center.x + window_size.x / 2.0;
    float top = window_center.y - window_size.y / 2.0;
    float bottom = window_center.y + window_size.y / 2.0;
	if (pixel.x > left && pixel.x < right && pixel.y > top && pixel.y < bottom) {
        COLOR = texture(screen_texture, SCREEN_UV);
    } else {
        COLOR = vec4(0.0);
	}
}
