class_name WalkingPlayerState extends PlayerState


func move_player(delta : float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction: Vector3 = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var target_velocity : Vector3 = direction * player.speed
	
	player.velocity.x = lerp(player.velocity.x, target_velocity.x, 1.0 - exp(-player.acceleration * delta))
	player.velocity.z = lerp(player.velocity.z, target_velocity.z , 1.0 - exp(-player.acceleration * delta))


func _custom_physics_process(delta : float) -> void:
	if player.movement_enabled:
		move_player(delta)
	
	player.move_and_slide()
	check_for_transition_criteria()


func check_for_transition_criteria() -> void:
	if !player.is_on_floor():
		state_machine.transition_to(FallingPlayerState)
		return
	
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	
	# switch to idle when recieving no input or movement is disabled
	if !input_dir || !player.movement_enabled:
		state_machine.transition_to(IdlePlayerState)
