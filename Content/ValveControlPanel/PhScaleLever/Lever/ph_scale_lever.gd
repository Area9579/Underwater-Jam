class_name PhScaleLever extends ValveControl

@onready var audio_stream_player_3d: AudioStreamPlayer3D = %AudioStreamPlayer3D

var interaction_handler : PhScaleLeverInteractionHandler = PhScaleLeverInteractionHandler.new(self)

@warning_ignore("unused_signal")
signal value_changed(value : float)
