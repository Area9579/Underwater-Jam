extends Node3D


const DAY_3 = preload("uid://behilqytfb3fh")



func _on_event_queue_event_queue_finished() -> void:
	SceneSwitcher.switch_to_day(DAY_3)
