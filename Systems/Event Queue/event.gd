class_name Event extends Node

@export_range(0.0, 10.0, 0.1) var post_task_wait_time : float = 0.0

@warning_ignore("unused_signal")
signal event_finished(event : Event)

signal event_enabled
signal event_disabled

var enabled : bool = false


func finish() -> void:
	if post_task_wait_time != 0.0:
		await get_tree().create_timer(post_task_wait_time).timeout
	event_finished.emit(self)


func enable() -> void:
	enabled = true
	event_enabled.emit()


func disable() -> void:
	enabled = false
	event_disabled.emit()
