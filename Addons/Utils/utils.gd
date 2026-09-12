class_name Utils extends Node

static func remap_with_clamp(val : float, start_min : float, start_max : float, target_min : float, target_max : float) -> float:
	return clampf(remap(val, start_min, start_max, target_min, target_max), target_min, target_max)
