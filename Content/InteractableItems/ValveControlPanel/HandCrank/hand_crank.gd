class_name HandCrank extends Area3D

var interaction_handler : HandCrankInteractionHandler = HandCrankInteractionHandler.new(self)
@onready var audio_stream_player_3d: AudioStreamPlayer3D = %AudioStreamPlayer3D

@warning_ignore("unused_signal")
signal increment_value
@warning_ignore("unused_signal")
signal decrement_value
