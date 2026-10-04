class_name ValveControl extends Node3D

signal finished

var player_won : bool = false


func finish() -> void:
	player_won = true
	finished.emit()
