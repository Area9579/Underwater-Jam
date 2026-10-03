class_name StartContAudioEventPlayer extends Node3D

@export var audio_players : Array[AudioStreamPlayer3D]
@export var event : Event

signal audio_started_playing


var is_finished : bool = false

func _ready() -> void:
	if !_are_nodes_valid():
		return
	connect_signals_from_audio_player()


func finish() -> void:
	is_finished = true


func connect_signals_from_audio_player() -> void:
	for audio_player in audio_players:
		audio_player.finished.connect(_on_audio_player_finished_playing.bind(audio_player))


func _on_audio_player_finished_playing(audio_player : AudioStreamPlayer3D) -> void:
	if audio_player == null:
		return
	
	if !is_finished:
		audio_player.play()
		return


func _on_event_enabled() -> void:
	if !_are_nodes_valid():
		return
	
	for audio_player in audio_players:
		if audio_player == null:
			continue
		audio_player.play()
	
	audio_started_playing.emit()
	event.finish()


func _on_event_disabled() -> void:
	pass


func _on_event_finished(_event: Event) -> void:
	if !_are_nodes_valid():
		return


func _are_nodes_valid() -> bool:
	if event == null:
		printerr("%s: Event is null! Unable to connect to EventQueue system" % self)
		return false
	
	return true
