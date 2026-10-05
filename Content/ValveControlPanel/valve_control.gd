class_name ValveControl extends Node3D

signal finished

@export var event : Event

var player_won : bool = false


func finish() -> void:
	player_won = true
	finished.emit()
	if event != null: event.finish()
