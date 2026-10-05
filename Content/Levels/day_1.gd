extends Node3D

const DAY_2 = preload("uid://wd7ppiwtndyt")



func _on_event_queue_event_queue_finished() -> void:
	SceneSwitcher.switch_to_day(DAY_2)
