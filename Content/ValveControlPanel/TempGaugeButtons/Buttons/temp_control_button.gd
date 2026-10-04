class_name TempControlButton extends Area3D

@onready var button_press_sequencer: Node3DTweenSequencer = %ButtonPressSequencer as Node3DTweenSequencer
@onready var pressed_audio_stream_player: AudioStreamPlayer3D = %PressedAudioStreamPlayer

var interaction_handler : TempControlButtonInteractionHandler = TempControlButtonInteractionHandler.new(self)


@warning_ignore("unused_signal")
signal pressed
