class_name FallingPlayerState extends PlayerState


func _custom_physics_process(delta : float) -> void:
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	check_for_transition_criteria()


func check_for_transition_criteria() -> void:
	if !player.is_on_floor():
		return
	
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	
	if input_dir:
		state_machine.transition_to(WalkingPlayerState)
	else:
		state_machine.transition_to(IdlePlayerState)
