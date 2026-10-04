class_name NutrientFlowCrank extends Area3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = %AudioStreamPlayer3D

var interaction_handler : NutrientFlowCrankInteractionHandler = NutrientFlowCrankInteractionHandler.new(self)

@warning_ignore("unused_signal")
signal value_changed(value : float)
