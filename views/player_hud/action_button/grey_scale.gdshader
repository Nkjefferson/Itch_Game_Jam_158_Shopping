shader_type canvas_item;
render_mode unshaded;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	float lumi = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
	COLOR.rgb = vec3(lumi);
}
