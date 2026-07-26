class_name TestInteractionHandler extends AbstractInteractionHandler

var test_interactable : TestInteractable


func _init(interactable_node : TestInteractable) -> void:
	super(interactable_node)
	test_interactable = interactable_node


func call_interact(_player : Player) -> void:
	if !Input.is_action_just_pressed("interact"):
		return
	test_interactable.label_3d.visible = !test_interactable.label_3d.visible
