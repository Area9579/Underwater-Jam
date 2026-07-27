class_name IdlePlayerState extends PlayerState


func _custom_physics_process(delta : float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, 1.0 - exp(-player.acceleration * delta))
	player.velocity.z = lerp(player.velocity.z, 0.0, 1.0 - exp(-player.acceleration * delta))
	
	player.move_and_slide()
	
	check_for_transition_criteria()


func check_for_transition_criteria() -> void:
	if !player.is_on_floor():
		state_machine.transition_to(FallingPlayerState)
		return
	
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "back")
	
	if !input_dir:
		return
	
	state_machine.transition_to(WalkingPlayerState)
