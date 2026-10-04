class_name ComputerInteractionHandler extends AbstractInteractionHandler

signal send_player_camera(camera : Camera3D)

var puter_is_active : bool = false


func _init(interactable_node : ComputerInteractable) -> void:
	super(interactable_node)


func do_interaction(player : FirstPersonEntityController) -> void:
	if puter_is_active == false: return
	is_interacting = true
	player.interaction_enabled = false
	player.look_enabled = false
	player.movement_enabled = false
	send_player_camera.emit(player.camera_3d)
	is_interacting = false



func is_correct_input_given() -> bool:
	if Input.is_action_just_pressed("interact"):
		return true
	return false


func fade_in_hover_effect() -> void:
	pass


func fade_out_hover_effect() -> void:
	pass
