class_name PanelSlider extends Node3D

const MOUSE_SENSITIVITY : float = 0.03

@export var event : Event
@onready var path_follow_3d: PathFollow3D = %PathFollow3D


func follow_mouse_relative_motion(input_event : InputEventMouseMotion) -> void:
	var motion : float = input_event.relative.y * MOUSE_SENSITIVITY
	path_follow_3d.progress_ratio = clampf(path_follow_3d.progress_ratio + motion, 0, 1)


func _on_slider_event_event_disabled() -> void:
	pass # Replace with function body.


func _on_slider_event_event_enabled() -> void:
	pass # Replace with function body.
