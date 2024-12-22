shader_type canvas_item;

uniform sampler2D wind_texture;
uniform float speed = 0.5;
uniform vec2 scale = vec2(1.0, 1.0);
uniform float angle = 0.0;

varying vec2 CUSTOM_UV;

void vertex() {
	CUSTOM_UV = (vec4(VERTEX, 0, 0) * SCREEN_MATRIX).rg;
}

void fragment() {
	float rad_dir = radians(-90.);
	float rad_rot = radians(angle);
	vec2 direction = vec2(sin(rad_dir), cos(rad_dir));
	vec2 uv = CUSTOM_UV.xy * scale;
	mat2 rotation_matrix = mat2(vec2(cos(rad_rot), -sin(rad_rot)), vec2(sin(rad_rot), cos(rad_rot)));
	uv = rotation_matrix * (uv - 0.5) + 0.5;
	uv = fract(uv + TIME * speed * direction);
	COLOR = texture(wind_texture, uv);
}
