shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, unshaded, shadows_disabled;

// Requires Forward+ or Mobile renderer (screen_texture + depth_texture).
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform sampler2D depth_texture : hint_depth_texture, repeat_disable, filter_linear_mipmap;

// Glass / refraction
uniform float glass_alpha : hint_range(0.0, 1.0) = 0.85;
uniform float distortion_strength : hint_range(0.0, 0.05) = 0.012;
uniform float distortion_speed : hint_range(0.0, 3.0) = 0.6;

// Depth fog
uniform vec4 fog_color_near : source_color = vec4(0.05, 0.25, 0.30, 1.0);
uniform vec4 fog_color_far  : source_color = vec4(0.0, 0.04, 0.09, 1.0);
uniform float fog_distance : hint_range(1.0, 100.0) = 15.0;

// Vignette / glass frame darkening
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.85;
uniform float vignette_radius : hint_range(0.05, 0.7) = 0.35;
uniform float vignette_softness : hint_range(0.01, 1.0) = 0.35;

// Caustics
uniform vec4 caustic_color : source_color = vec4(0.75, 0.95, 0.9, 1.0);
uniform float caustic_strength : hint_range(0.0, 1.0) = 0.25;
uniform float caustic_speed : hint_range(0.0, 2.0) = 0.3;

// Marine snow
uniform float particle_density : hint_range(1.0, 30.0) = 10.0;
uniform float particle_speed : hint_range(0.0, 1.0) = 0.06;
uniform float particle_size : hint_range(0.01, 0.2) = 0.07;

varying vec2 local_uv;

void vertex() {
	local_uv = UV;
}

float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float value_noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	float a = hash(i);
	float b = hash(i + vec2(1.0, 0.0));
	float c = hash(i + vec2(0.0, 1.0));
	float d = hash(i + vec2(1.0, 1.0));
	vec2 u = f * f * (3.0 - 2.0 * f);
	return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

float caustic_pattern(vec2 uv, float t) {
	vec2 p = uv * 6.0;
	float c1 = sin(p.x + t) + sin(p.y * 1.3 - t * 1.1);
	float c2 = sin((p.x + p.y) * 0.7 + t * 0.8);
	float v = (c1 + c2) * 0.25 + 0.5;
	return pow(clamp(v, 0.0, 1.0), 3.0);
}

void fragment() {
	float t = TIME;

	// refraction wobble
	vec2 warp_uv = local_uv * 3.0 + vec2(t * distortion_speed * 0.1, t * distortion_speed * 0.07);
	float n1 = value_noise(warp_uv);
	float n2 = value_noise(warp_uv + vec2(5.2, 1.3));
	vec2 offset = (vec2(n1, n2) - 0.5) * distortion_strength;
	vec2 screen_uv = SCREEN_UV + offset;

	vec3 scene_color = textureLod(screen_texture, screen_uv, 0.0).rgb;

	// reconstruct view-space depth for fog falloff
	float raw_depth = textureLod(depth_texture, screen_uv, 0.0).r;
	vec3 ndc = vec3(screen_uv * 2.0 - 1.0, raw_depth);
	vec4 view_pos = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view_pos.xyz /= view_pos.w;
	float scene_depth = -view_pos.z;

	float fog_t = clamp(scene_depth / fog_distance, 0.0, 1.0);
	vec3 fog = mix(fog_color_near.rgb, fog_color_far.rgb, fog_t);
	float fog_weight = mix(0.12, 0.85, fog_t); // some tint even up close, like water always does
	vec3 color = mix(scene_color, fog, fog_weight);

	// caustics
	float cp = caustic_pattern(local_uv, t * caustic_speed);
	color += cp * caustic_strength * caustic_color.rgb * (1.0 - fog_t * 0.5);

	// vignette / glass frame
	vec2 centered = local_uv - 0.5;
	float vig = smoothstep(vignette_radius, vignette_radius + vignette_softness, length(centered));
	color = mix(color, vec3(0.0), clamp(vig * vignette_strength, 0.0, 0.95));

	ALBEDO = color;
	ALPHA = glass_alpha;
}
