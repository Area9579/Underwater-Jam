class_name PhScaleLeverInteractionHandler extends AbstractInteractionHandler

var lever : PhScaleLever

var interacting_entity : FirstPersonEntityController

func _init(interactable_node : PhScaleLever) -> void:
	super(interactable_node)
	
	if interactable_node is not PhScaleLever:
		printerr("%s: Interactable node: %s is not a PanelSlider" % [self, interactable_node])
		return
	
	lever = interactable_node


func _input(event: InputEvent) -> void:
	if !is_interacting:
		return
	
	# check for end of interaction
	if event.is_action_released("interact"):
		is_interacting = false
		interacting_entity.look_enabled = true
		interacting_entity.movement_enabled = true
	
	if event is not InputEventMouseMotion:
		return
	if !is_enabled:
		return
	
	follow_mouse_relative_motion(event as InputEventMouseMotion)



func follow_mouse_relative_motion(event : InputEventMouseMotion) -> void:
	var height : float = abs(get_viewport().get_visible_rect().end.y - get_viewport().get_visible_rect().position.y)
	lever.value_changed.emit(Utils.remap_with_clamp(event.screen_relative.y, -height/2, height/2, -1.0, 1.0))



func is_correct_input_given() -> bool:
	if Input.is_action_pressed("interact"):
		return true
	return false


func do_interaction(entity : FirstPersonEntityController) -> void:
	interacting_entity = entity
	is_interacting = true
	interacting_entity.look_enabled = false
	interacting_entity.movement_enabled = false


func fade_in_hover_effect() -> void:
	pass


func fade_out_hover_effect() -> void:
	pass
