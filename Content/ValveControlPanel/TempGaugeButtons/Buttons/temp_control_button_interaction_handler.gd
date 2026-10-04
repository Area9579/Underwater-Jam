class_name TempControlButtonInteractionHandler extends AbstractInteractionHandler

var temp_control_button : TempControlButton

func _init(interactable_node : TempControlButton) -> void:
	temp_control_button = interactable_node
	super(interactable_node)


func is_correct_input_given() -> bool:
	if Input.is_action_just_pressed("interact"):
		return true
	return false


func fade_in_hover_effect() -> void:
	pass


func fade_out_hover_effect() -> void:
	pass


func do_interaction(_entity : FirstPersonEntityController) -> void:
	is_interacting = true
	temp_control_button.pressed_audio_stream_player.play()
	await temp_control_button.button_press_sequencer.do_tween_sequence()
	temp_control_button.pressed.emit()
	is_interacting = false
