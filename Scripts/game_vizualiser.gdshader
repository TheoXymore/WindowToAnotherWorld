shader_type canvas_item;

uniform vec2 window_center;
uniform vec2 window_size;
uniform float window_rotation;

uniform sampler2D screen_texture: hint_screen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 pixel = FRAGCOORD.xy;	
	vec2 centered_pixel = pixel - window_center;
	
	vec2 rotated_pixel;
    rotated_pixel.x = centered_pixel.x * cos(window_rotation) + centered_pixel.y * sin(window_rotation);
    rotated_pixel.y = -centered_pixel.x * sin(window_rotation) + centered_pixel.y * cos(window_rotation);
    if (abs(rotated_pixel.x) < window_size.x / 2.0 && abs(rotated_pixel.y) < window_size.y / 2.0) {
        COLOR = texture(screen_texture, SCREEN_UV);
    } else {
    	COLOR = vec4(0.0);
	}
	//float left = window_center.x - window_size.x / 2.0;
    //float right = window_center.x + window_size.x / 2.0;
    //float top = window_center.y - window_size.y / 2.0;
    //float bottom = window_center.y + window_size.y / 2.0;
	//if (pixel.x > left && pixel.x < right && pixel.y > top && pixel.y < bottom) {
    //    COLOR = texture(screen_texture, SCREEN_UV);
    //} else {
    //    COLOR = vec4(0.0);
	//}
}
