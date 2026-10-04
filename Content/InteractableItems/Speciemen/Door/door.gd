class_name Door extends Area3D

@warning_ignore("unused_signal")
signal light_status

@onready var hover_text: Label3D = $HoverText
@onready var uv_light: SpotLight3D = $"../UVLight"

var interaction_handler : SpecimenInteractionHandler = SpecimenInteractionHandler.new(self)

func _ready() -> void:
	interaction_handler.door_change.connect(door_changed)

## Garb door status from Interaction handler signal being emitted on input
func door_changed(new_door_status: bool):
	hover_text.text = str(new_door_status)
	
	if new_door_status:
		uv_light.light_energy = 16
		light_status.emit(true)
	elif not new_door_status:
		uv_light.light_energy = 0
		light_status.emit(false)
