class_name HandCrankInteractionHandler extends AbstractInteractionHandler

var hand_crank : HandCrank


func _init(interactable_node : HandCrank) -> void:
	super(interactable_node)
	if interactable_node is not HandCrank:
		printerr("%s: Interactable node: %s is not a HandCrank" % [self, interactable_node])
		return
	hand_crank = interactable_node


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
	var curr_rotation = hand_crank.global_rotation
	var tween = create_tween()
	tween.tween_property(hand_crank, "global_rotation", Vector3(curr_rotation.x, curr_rotation.y + deg_to_rad(90), curr_rotation.z), 0.5)
	await tween.finished
	is_interacting = false
