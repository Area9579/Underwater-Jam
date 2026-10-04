class_name PillDispenser extends Node3D

@onready var area_3d: PillDispenserInteractable = $Area3D as PillDispenserInteractable
@onready var pill_event: Event = $PillEvent


func _ready() -> void:
	pill_event.event_enabled.connect(_on_event_enabled)
	pill_event.event_disabled.connect(_on_event_disabled)


func _on_event_enabled() -> void:
	pass


func _on_event_disabled() -> void:
	pass
