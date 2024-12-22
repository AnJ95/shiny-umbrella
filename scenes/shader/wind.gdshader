shader_type canvas_item;

uniform sampler2D noise_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(noise_texture,UV*TEXTURE_PIXEL_SIZE);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
