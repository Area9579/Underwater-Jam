class_name NutrientFlowCrankInteractionHandler extends AbstractInteractionHandler

var nutrient_flow_crank : NutrientFlowCrank

var interacting_entity : FirstPersonEntityController
var audio_stream_pos : float = 0.0

func _init(interactable_node : NutrientFlowCrank) -> void:
	super(interactable_node)
	
	if interactable_node is not NutrientFlowCrank:
		printerr("%s: Interactable node: %s is not a PanelSlider" % [self, interactable_node])
		return
	
	nutrient_flow_crank = interactable_node


func _input(event: InputEvent) -> void:
	if !is_interacting:
		return
	
	# check for end of interaction
	if event.is_action_released("interact"):
		is_interacting = false
		interacting_entity.look_enabled = true
		interacting_entity.movement_enabled = true
	
	if event is not InputEventMouseMotion:
		return
	if !is_enabled:
		return
	
	follow_mouse_relative_motion(event as InputEventMouseMotion)



func follow_mouse_relative_motion(event : InputEventMouseMotion) -> void:
	var width : float = abs(get_viewport().get_visible_rect().end.x - get_viewport().get_visible_rect().position.x)
	nutrient_flow_crank.value_changed.emit(Utils.remap_with_clamp(event.screen_relative.x, -width/2, width/2, -1.0, 1.0))
	play_squeak()

func play_squeak() -> void:
	if nutrient_flow_crank.audio_stream_player_3d.playing:
		return
	
	nutrient_flow_crank.audio_stream_player_3d.play(audio_stream_pos)
	await get_tree().create_timer(0.1).timeout
	audio_stream_pos = nutrient_flow_crank.audio_stream_player_3d.get_playback_position()
	nutrient_flow_crank.audio_stream_player_3d.stop()


func is_correct_input_given() -> bool:
	if Input.is_action_pressed("interact"):
		return true
	return false


func do_interaction(entity : FirstPersonEntityController) -> void:
	interacting_entity = entity
	is_interacting = true
	interacting_entity.look_enabled = false
	interacting_entity.movement_enabled = false


func fade_in_hover_effect() -> void:
	pass


func fade_out_hover_effect() -> void:
	pass
