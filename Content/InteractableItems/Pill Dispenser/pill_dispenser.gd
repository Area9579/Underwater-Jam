class_name PillDispenser extends Node3D

@onready var area_3d: PillDispenserInteractable = $Area3D as PillDispenserInteractable
@onready var pill_event: Event = $PillEvent
@onready var pill: MeshInstance3D = $Pill


func _ready() -> void:
	pill_event.event_enabled.connect(_on_event_enabled)
	pill_event.event_disabled.connect(_on_event_disabled)
	area_3d.interaction_handler.we_done_here.connect(finish_up)


func _on_event_enabled() -> void:
	pill.show()
	area_3d.interaction_handler.enable()


func _on_event_disabled() -> void:
	pill.hide()
	area_3d.interaction_handler.disable()


func finish_up() -> void:
	pill_event.finish()
