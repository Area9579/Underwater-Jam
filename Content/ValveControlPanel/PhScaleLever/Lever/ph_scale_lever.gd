class_name PhScaleLever extends ValveControl


var interaction_handler : PhScaleLeverInteractionHandler = PhScaleLeverInteractionHandler.new(self)

@warning_ignore("unused_signal")
signal value_changed(value : float)

func follow_mouse_relative_motion(event : InputEventMouseMotion) -> void:
	var height : float = abs(get_viewport().get_visible_rect().end.y - get_viewport().get_visible_rect().position.y)
	value_changed.emit(Utils.remap_with_clamp(event.screen_relative.y, -height/2, height/2, -1.0, 1.0))
