class_name SpecimenInteractionHandler extends AbstractInteractionHandler

@warning_ignore("unused_signal")
signal door_change

var _door: Door
var door_status: bool = false

func _init(interactable_node : Door) -> void:
	super(interactable_node)
	
	if interactable_node is not Door:
		printerr("%s: Interactable node: %s is not a Door" % [self, interactable_node])
		return
	
	_door = interactable_node


func is_correct_input_given() -> bool:
	#if Input.is_action_pressed("interact") || Input.is_action_pressed("alt_interact"):
		#return true
	if Input.is_action_just_pressed("interact") || Input.is_action_just_pressed("alt_interact"):
		return true
	return false


func do_interaction(_entity : FirstPersonEntityController) -> void:
	is_interacting = true
	inverse_door()
	is_interacting = false

func inverse_door():
	door_status = not door_status
	door_change.emit(door_status)

func fade_in_hover_effect() -> void:
	pass

func fade_out_hover_effect() -> void:
	pass
