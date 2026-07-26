class_name PlayerStateMachine extends StateMachine

@export var player : Player

@export var look_enabled : bool = true

func _ready() -> void:
	if player == null:
		printerr("%s: No player object is set in export" % self.name)
		return
	
	setup_states()


func setup_states() -> void:
	for state in states:
		(state as PlayerState).player = self.player
		state.state_machine = self
	
	curr_state = get_first_state_of_type(IdlePlayerState)


## Head rotation for first-person controls
func _unhandled_input(event: InputEvent) -> void:
	if !look_enabled:
		return
	
	if event is InputEventMouseMotion:
		player.rotate_y(-event.relative.x * player.mouse_sensitivity)
		player.head.rotate_x(-event.relative.y * player.mouse_sensitivity)
		player.head.rotation.x = clamp(player.head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event is InputEventMouseButton and event.pressed:
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
