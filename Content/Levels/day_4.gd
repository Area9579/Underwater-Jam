extends Node3D

const DAY_5 = preload("uid://10moq2tersbe")


func _on_event_queue_event_queue_finished() -> void:
	SceneSwitcher.switch_to_day(DAY_5)
