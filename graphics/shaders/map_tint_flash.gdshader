shader_type canvas_item;
render_mode blend_mix;

uniform vec4 tone : source_color;
uniform vec4 color : source_color;
const vec3 lumaF = vec3(0.299, 0.587, 0.114);

void fragment() {
	vec4 frag = texture(TEXTURE, UV);
	vec3 colorBlending = mix(frag.rgb, color.rgb, vec3(color.a));
	float grayScale = dot(lumaF, frag.rgb);
	vec3 colorAndGrayBlending = mix(colorBlending, vec3(grayScale), vec3(tone.a));
	vec3 toneAndColorBlending = tone.rgb + colorAndGrayBlending;

	COLOR.rgb = toneAndColorBlending;
	COLOR.a = frag.a * COLOR.a;
}