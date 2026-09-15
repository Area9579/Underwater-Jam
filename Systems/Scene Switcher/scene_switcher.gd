extends Node

@onready var fade_to_black: ControlTween = %FadeToBlack
@onready var fade_from_black: ControlTween = %FadeFromBlack

func switch_scene(target_scene : PackedScene) -> void:
	fade_to_black.do_tween()
	
	# insurance to make sure await doesnt call without being able to actually end
	if fade_to_black.tween.is_running():
		await fade_to_black.tween.finished
	
	get_tree().change_scene_to_packed(target_scene)
	
	# insurance
	await get_tree().process_frame
	
	fade_from_black.do_tween()
	
	if fade_from_black.tween.is_running():
		await fade_from_black.tween.finished
