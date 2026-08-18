class_name Event extends Node

@warning_ignore("unused_signal")
signal event_finished(event : Event)

signal event_enabled
signal event_disabled

var enabled : bool = false


func finish() -> void:
	event_finished.emit(self)


func enable() -> void:
	enabled = true
	event_enabled.emit()


func disable() -> void:
	enabled = false
	event_disabled.emit()
