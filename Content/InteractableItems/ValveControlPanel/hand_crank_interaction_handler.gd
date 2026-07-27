class_name HandCrankInteractionHandler extends AbstractInteractionHandler

var hand_crank : HandCrank


func _init(interactable_node : HandCrank) -> void:
	super(interactable_node)
	
	if interactable_node is not HandCrank:
		printerr("%s: Interactable node: %s is not a HandCrank" % [self, interactable_node])
		return
	
	hand_crank = interactable_node



func is_correct_input_given() -> bool:
	if Input.is_action_pressed("interact") || Input.is_action_pressed("alt_interact"):
		return true
	return false



func do_interaction(_entity : FirstPersonEntityController) -> void:
	is_interacting = true
	var tween = create_tween()
	
	if Input.is_action_pressed("interact"):
		tween.tween_method(add_to_rotation, 0, 1, 0.01)
	elif Input.is_action_pressed("alt_interact"):
		tween.tween_method(subtract_from_rotation, 0, 1, 0.01)
	
	await tween.finished
	is_interacting = false


func add_to_rotation(value : float) -> void:
	hand_crank.rotation.y += deg_to_rad(value)


func subtract_from_rotation(value : float) -> void:
	hand_crank.rotation.y -= deg_to_rad(value)


func fade_in_hover_effect() -> void:
	pass


func fade_out_hover_effect() -> void:
	pass
