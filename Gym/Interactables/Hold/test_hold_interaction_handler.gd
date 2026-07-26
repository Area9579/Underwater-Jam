class_name TestHoldInteractionHandler extends AbstractInteractionHandler

const HOLD_THRESHOLD_MS : float = 1500

var test_interactable : TestHoldInteractable
var is_holding : bool = false
var hold_start_timestamp : float = INF


func _init(interactable_node : TestHoldInteractable) -> void:
	super(interactable_node)
	test_interactable = interactable_node


func is_correct_input_given() -> bool:
	if Input.is_action_just_pressed("interact"):
		hold_start_timestamp = Time.get_ticks_msec()
		return false
	
	if Input.is_action_pressed("interact"):
		if Time.get_ticks_msec() - hold_start_timestamp > HOLD_THRESHOLD_MS:
			hold_start_timestamp = INF
			return true
	
	return false


func fade_in_hover_effect() -> void:
	test_interactable.hover_label.visible = true
	test_interactable.interaction_label.visible = false


func fade_out_hover_effect() -> void:
	test_interactable.hover_label.visible = false
	test_interactable.interaction_label.visible = false


func do_interaction(_player : Player) -> void:
	is_interacting = true
	test_interactable.hover_label.visible = false
	test_interactable.interaction_label.visible = !test_interactable.interaction_label.visible
	await get_tree().create_timer(0.5).timeout
	is_interacting = false
