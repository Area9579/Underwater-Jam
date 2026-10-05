extends Node3D


func _on_event_queue_event_queue_finished() -> void:
	# TODO: fix this
	await SceneSwitcher.fade_to_black.do_tween()
	get_tree().quit()
