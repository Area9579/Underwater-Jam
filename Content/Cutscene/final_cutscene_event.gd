class_name FinalCutsceneEvent extends Event

@export var player : Player
@export var its_gonna_break_the_glass : AudioStreamPlayer3D
@export var ear_ringing : AudioStreamPlayer3D
@export var wrench_hit_on_glass : AudioStreamPlayer3D
@export var glass_shattering : AudioStreamPlayer3D
@export var light_hum : AudioStreamPlayer3D
@export var tween_player_to_vat : Node3DTween
@export var glass_shattered : Node3D
@export var glass_whole : Node3D
@export var vat : Specimen_Controller

@export var all_tasks : EventStage


func enable() -> void:
	super()
	play_anim()


func disable() -> void:
	super()
	all_tasks.disable_all_tasks()
	


func play_anim() -> void:
	await SceneSwitcher.fade_to_black.do_tween()
	
	# tween player to vat
	player.velocity = Vector3.ZERO
	player.look_enabled = false
	player.interaction_enabled = false
	player.movement_enabled = false
	player.camera_3d.rotation = Vector3.ZERO
	await tween_player_to_vat.do_tween()
	
	await SceneSwitcher.fade_from_black.do_tween()
	
	
	# oh noooo its gonna break the glass
	vat._door_button.door_changed(true) # open vat
	its_gonna_break_the_glass.play()
	await its_gonna_break_the_glass.finished
	
	# fade to white and play ear ringing noise
	ear_ringing.play()
	await SceneSwitcher.fade_to_white.do_tween()
	await get_tree().create_timer(0.5).timeout
	# TODO: switch to broken
	wrench_hit_on_glass.play()
	glass_whole.hide()
	glass_shattered.show()
	await wrench_hit_on_glass.finished
	glass_shattering.play()
	light_hum.play()
	await SceneSwitcher.fade_from_white.do_tween()
	
	await get_tree().create_timer(5.0).timeout
	finish()
	
