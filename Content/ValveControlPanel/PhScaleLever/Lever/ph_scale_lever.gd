class_name PhScaleLever extends ValveControl

@export var audio_stream_player_3d: AudioStreamPlayer3D
@export var parent_mesh : MeshInstance3D
var interaction_handler : PhScaleLeverInteractionHandler = PhScaleLeverInteractionHandler.new(self)

@warning_ignore("unused_signal")
signal value_changed(value : float)
