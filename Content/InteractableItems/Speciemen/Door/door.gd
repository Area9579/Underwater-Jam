class_name Door extends Area3D

@warning_ignore("unused_signal")
signal light_status

const LIGHT_ON_ENERGY: float = 16.0

@onready var hover_text: Label3D = $HoverText
@onready var uv_light: SpotLight3D = $"../UVLight"
@onready var vat_lever: MeshInstance3D = %VatLever
@onready var vat_door_plate = $"../../VatDoorPlate"

@export var event : Event

var interaction_handler : SpecimenInteractionHandler = SpecimenInteractionHandler.new(self)

func _ready() -> void:
	interaction_handler.door_change.connect(door_changed)




## Garb door status from Interaction handler signal being emitted on input
func door_changed(new_door_status: bool):
	hover_text.text = str(new_door_status)
	var lever_tween: Tween = create_tween()
	if event != null: event.finish()
	if new_door_status:
		lever_tween.tween_property(vat_lever, "rotation:z", deg_to_rad(-37.7), 1.0)
		await lever_tween.finished 
		vat_door_plate.collapse()
		await flicker_light(LIGHT_ON_ENERGY)
		light_status.emit(true)
	elif not new_door_status:
		lever_tween.tween_property(vat_lever, "rotation:z", deg_to_rad(-133.5), 1.0)
		await lever_tween.finished
		vat_door_plate.expand()
		await flicker_light(0.0)
		light_status.emit(false)

## Flickers the UV light on/off, then settles on final_energy
func flicker_light(final_energy: float, flicker_count: int = 7) -> void:
	var flicker_tween: Tween = create_tween()
	for i in flicker_count:
		flicker_tween.tween_callback(func(): uv_light.light_energy = LIGHT_ON_ENERGY)
		flicker_tween.tween_interval(randf_range(0.03, 0.1))
		flicker_tween.tween_callback(func(): uv_light.light_energy = 0.0)
		flicker_tween.tween_interval(randf_range(0.03, 0.1))
	flicker_tween.tween_callback(func(): uv_light.light_energy = final_energy)
	await flicker_tween.finished


func _on_event_event_disabled() -> void:
	interaction_handler.disable()


func _on_event_event_enabled() -> void:
	interaction_handler.enable()
