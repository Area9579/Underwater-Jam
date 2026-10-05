class_name DailyOrderInteractionHandler extends AbstractInteractionHandler

var daily_order_sheet : DailyOrderSheet


func _init(interactable_node : DailyOrderSheet) -> void:
	super(interactable_node)
	daily_order_sheet = interactable_node


func do_interaction(player : FirstPersonEntityController) -> void:
	is_interacting = true
	daily_order_sheet.reparent((player as Player).sheet_marker)
	daily_order_sheet.position = Vector3(0, -0.5, 0)
	daily_order_sheet.rotation_degrees = Vector3(0, 0, 0)
	(player as Player).has_sheet = true
	(player as Player).sheet_equiped = true
	daily_order_sheet.pull_up.do_tween()
	daily_order_sheet.daily_order_event.finish()
	is_interacting = false


func is_correct_input_given() -> bool:
	if Input.is_action_just_pressed("interact"):
		return true
	return false


func fade_in_hover_effect() -> void:
	pass


func fade_out_hover_effect() -> void:
	pass
