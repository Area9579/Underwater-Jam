class_name NutrientFlowCrankInteractionHandler extends AbstractInteractionHandler

var nutrient_flow_crank : NutrientFlowCrank
var audio_stream_pos : float = 0.0

func _init(interactable_node : NutrientFlowCrank) -> void:
	super(interactable_node)
	
	if interactable_node is not NutrientFlowCrank:
		printerr("%s: Interactable node: %s is not a NutrientFlowCrank" % [self, interactable_node])
		return
	
	nutrient_flow_crank = interactable_node


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
	
	play_squeak()
	await tween.finished
	
	is_interacting = false

func play_squeak() -> void:
	if nutrient_flow_crank.audio_stream_player_3d.playing:
		return
	
	nutrient_flow_crank.audio_stream_player_3d.play(audio_stream_pos)
	await get_tree().create_timer(0.1).timeout
	audio_stream_pos = nutrient_flow_crank.audio_stream_player_3d.get_playback_position()
	nutrient_flow_crank.audio_stream_player_3d.stop()
	

func add_to_rotation(value : float) -> void:
	nutrient_flow_crank.rotation.y += deg_to_rad(value)
	nutrient_flow_crank.increment_value.emit()


func subtract_from_rotation(value : float) -> void:
	nutrient_flow_crank.rotation.y -= deg_to_rad(value)
	nutrient_flow_crank.decrement_value.emit()


func fade_in_hover_effect() -> void:
	pass


func fade_out_hover_effect() -> void:
	pass
