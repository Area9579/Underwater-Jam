class_name FinalCutsceneEvent extends Event

@export var player : Player

@export var its_gonna_break_the_glass : AudioStreamPlayer3D
@export var ear_ringing : AudioStreamPlayer3D
@export var wrench_hit_on_glass : AudioStreamPlayer3D
@export var glass_shattering : AudioStreamPlayer3D
@export var light_hum : AudioStreamPlayer3D
@export var emergency_alarm : AudioStreamPlayer3D
@export var heartbeat : AudioStreamPlayer3D

@export var animate_player_to_vat : AnimationPlayer
@export var glass_shattered : Node3D
@export var glass_whole : Node3D
@export var vat : Specimen_Controller
@export var particles : CPUParticles3D
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
	
	animate_player_to_vat.play("player_to_vat")
	await animate_player_to_vat.animation_finished
	#player.head.rotation = Vector3(10.0, 0.0, 0.0)
	#player.camera_3d.rotation = Vector3.ZERO
	
	await SceneSwitcher.fade_from_black.do_tween()
	
	
	# oh noooo its gonna break the glass
	vat._door_button.door_changed(true) # open vat
	its_gonna_break_the_glass.play()
	await its_gonna_break_the_glass.finished
	
	# fade to white and play ear ringing noise
	ear_ringing.play()
	var tween_out_alarm : Tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween_out_alarm.tween_property(emergency_alarm, "volume_db", -80, 0.5)
	var tween_out_heartbeat : Tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween_out_heartbeat.tween_property(heartbeat, "volume_db", -80, 0.5)
	
	await SceneSwitcher.fade_to_white.do_tween()
	await get_tree().create_timer(0.5).timeout
	# TODO: switch to broken
	wrench_hit_on_glass.play()
	glass_whole.hide()
	glass_shattered.show()
	await wrench_hit_on_glass.finished
	glass_shattering.play()
	light_hum.play()
	Engine.time_scale = 0.2
	particles.emitting = true
	SceneSwitcher.fade_from_white.do_tween()
	SceneSwitcher.fade_from_white.tween.set_speed_scale(1.2)
	await SceneSwitcher.fade_from_white.tween_finished
	await get_tree().create_timer(1.0, true, false, true).timeout
	finish()
	
