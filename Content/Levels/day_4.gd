extends Node3D

const DAY_5 = preload("uid://10moq2tersbe")

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		SceneSwitcher.switch_to_day(DAY_5)


func _on_event_queue_event_queue_finished() -> void:
	SceneSwitcher.switch_to_day(DAY_5)
