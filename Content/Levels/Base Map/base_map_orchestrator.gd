class_name BaseMapOrchestrator extends Node3D


func handle_player_menuing_inputs(event: InputEvent) -> void:
	# show cursor in first person mode
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# capture cursor on mouse click
	if event is InputEventMouseButton and event.pressed:
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	handle_player_menuing_inputs(event)
