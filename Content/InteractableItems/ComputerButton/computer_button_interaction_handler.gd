class_name ComputerButtonInteractionHandler extends AbstractInteractionHandler

var computer_button : ComputerButton

func _init(interactable_node : ComputerButton) -> void:
	super(interactable_node)
	computer_button = interactable_node


func do_interaction(_player : FirstPersonEntityController) -> void:
	is_interacting = true
	computer_button.play_button_tween()
	is_interacting = false


func is_correct_input_given() -> bool:
	if Input.is_action_just_pressed("interact"):
		return true
	return false


func fade_in_hover_effect() -> void:
	computer_button.label_3d.visible = true


func fade_out_hover_effect() -> void:
	computer_button.label_3d.visible = false
