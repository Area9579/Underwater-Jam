## This class serves as 
class_name AudioEventPlayer extends Node3D

@export var audio_player : AudioStreamPlayer3D
@export var event : Event

signal audio_started_playing
signal audio_ended_playing

func _ready() -> void:
	if !_are_nodes_valid():
		return
	connect_signals_from_audio_player()


func connect_signals_from_audio_player() -> void:
	audio_player.finished.connect(_on_audio_player_finished_playing)


func _on_audio_player_finished_playing() -> void:
	event.finish()
	audio_ended_playing.emit()


func _on_event_enabled() -> void:
	if !_are_nodes_valid():
		return
	
	audio_player.play()
	audio_started_playing.emit()


func _on_event_disabled() -> void:
	if !_are_nodes_valid():
		return
	
	audio_player.stop()


func _on_event_finished(_event: Event) -> void:
	if !_are_nodes_valid():
		return


func _are_nodes_valid() -> bool:
	if audio_player == null:
		printerr("%s: Audio player is null! Unable to play audio" % self)
		return false
	
	if event == null:
		printerr("%s: Event is null! Unable to connect to EventQueue system" % self)
		return false
	
	return true
