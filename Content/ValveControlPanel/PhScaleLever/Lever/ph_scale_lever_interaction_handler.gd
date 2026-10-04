class_name PhScaleLeverInteractionHandler extends AbstractHoldInteractionHandler

func is_correct_input_just_pressed() -> bool:
	if Input.is_action_just_pressed("interact"):
		return true
	return false


func is_correct_input_held() -> bool:
	if Input.is_action_pressed("interact"):
		return true
	return false


func fade_in_hover_effect() -> void:
	pass


func fade_out_hover_effect() -> void:
	pass


func do_interaction(entity : FirstPersonEntityController) -> void:
	is_interacting = true
	
	
	is_interacting = false
