class_name TestHoldInteractable extends RigidBody3D

@export var event : Event

@onready var hover_label: Label3D = %HoverLabel
@onready var interaction_label: Label3D = %InteractionLabel

var interaction_handler : TestHoldInteractionHandler = TestHoldInteractionHandler.new(self)


func _on_event_event_disabled() -> void:
	interaction_handler.disable()


func _on_event_event_enabled() -> void:
	interaction_handler.enable()
