extends CanvasLayer

@onready var fade_to_black: ControlTween = %FadeToBlack
@onready var fade_from_black: ControlTween = %FadeFromBlack
@onready var fade_to_white: ControlTween = %FadeToWhite
@onready var fade_from_white: ControlTween = %FadeFromWhite

var is_switching : bool = false

func switch_to_scene(packed_scene : PackedScene) -> void:
	if is_switching:
		return
	is_switching = true
	
	await fade_to_black.do_tween()
	
	var error : Error = get_tree().change_scene_to_packed(packed_scene)
	if error != Error.OK:
		push_warning("%s: unable to transition to %s properly" % [self, packed_scene.instantiate().name])
	
	await fade_from_black.do_tween()
	
	is_switching = false


func switch_to_day(next_day : PackedScene) -> void:
	# TODO: play fall asleep up anim :)
	# TODO: play wake up anim :)
	await switch_to_scene(next_day)
