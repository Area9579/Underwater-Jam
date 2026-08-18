class_name DailyOrderInteractionHandler extends AbstractInteractionHandler

var daily_order_sheet : DailyOrderSheet


func _init(interactable_node : DailyOrderSheet) -> void:
	super(interactable_node)
	daily_order_sheet = interactable_node


func do_interaction(player : FirstPersonEntityController) -> void:
	is_interacting = true
	daily_order_sheet.reparent((player as Player).sheet_marker)
	daily_order_sheet.position = Vector3(0, 0, 0)
	daily_order_sheet.rotation_degrees = Vector3(0, 0, 0)
	(player as Player).has_sheet = true
	(player as Player).sheet_equiped = true


func is_correct_input_given() -> bool:
	if Input.is_action_just_pressed("interact"):
		return true
	return false


func fade_in_hover_effect() -> void:
	daily_order_sheet.test_label.visible = true


func fade_out_hover_effect() -> void:
	daily_order_sheet.test_label.visible = false
