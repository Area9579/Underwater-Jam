class_name TestClickInteractionHandler extends AbstractInteractionHandler

var test_interactable : TestInteractable


func _init(interactable_node : TestInteractable) -> void:
	super(interactable_node)
	test_interactable = interactable_node


func is_correct_input_given() -> bool:
	if Input.is_action_just_pressed("interact"):
		return true
	return false


func fade_in_hover_effect() -> void:
	test_interactable.hover_label.visible = true
	test_interactable.interaction_label.visible = false


func fade_out_hover_effect() -> void:
	test_interactable.hover_label.visible = false
	test_interactable.interaction_label.visible = false


func do_interaction(_entity : FirstPersonEntityController) -> void:
	is_interacting = true
	test_interactable.hover_label.visible = false
	test_interactable.interaction_label.visible = !test_interactable.interaction_label.visible
	test_interactable.event.finish()
	await get_tree().create_timer(0.5).timeout
	is_interacting = false
