class_name PanelSliderInteractionHandler extends AbstractInteractionHandler

var panel_slider : PanelSlider

var interacting_entity : FirstPersonEntityController

func _init(interactable_node : PanelSlider) -> void:
	super(interactable_node)
	
	if interactable_node is not PanelSlider:
		printerr("%s: Interactable node: %s is not a PanelSlider" % [self, interactable_node])
		return
	
	panel_slider = interactable_node


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
	
	panel_slider.follow_mouse_relative_motion(event as InputEventMouseMotion)


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
