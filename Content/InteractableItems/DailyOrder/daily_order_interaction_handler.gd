class_name DailyOrderInteractionHandler extends AbstractInteractionHandler


func do_interaction(_player : Player) -> void:
	is_interacting = true
	
	is_interacting = false


func is_correct_input_given() -> bool:
	if Input.is_action_just_pressed("interact"):
		return true
	return false


func fade_in_hover_effect() -> void:
	pass


func fade_out_hover_effect() -> void:
	pass
