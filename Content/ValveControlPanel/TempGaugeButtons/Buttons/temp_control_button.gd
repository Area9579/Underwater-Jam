class_name TempControlButton extends Area3D

@export var button_press_sequencer: Node3DTweenSequencer
@export var pressed_audio_stream_player: AudioStreamPlayer3D

var interaction_handler : TempControlButtonInteractionHandler = TempControlButtonInteractionHandler.new(self)


@warning_ignore("unused_signal")
signal pressed
