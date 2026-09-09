class_name PanelSlider extends Node3D

const MOUSE_SENSITIVITY : float = 0.003

@export var event : Event
@onready var path_follow_3d: PathFollow3D = %PathFollow3D

var interaction_handler : PanelSliderInteractionHandler = PanelSliderInteractionHandler.new(self)

#func _input(input_event: InputEvent) -> void:
	#if input_event is not InputEventMouseMotion:
		#return
	#follow_mouse_relative_motion(input_event)

func follow_mouse_relative_motion(input_event : InputEventMouseMotion) -> void:
	var motion : float = input_event.relative.y * MOUSE_SENSITIVITY
	path_follow_3d.progress_ratio = clampf(path_follow_3d.progress_ratio + motion, 0, 1)


func _on_slider_event_event_disabled() -> void:
	interaction_handler.disable()


func _on_slider_event_event_enabled() -> void:
	interaction_handler.enable()
