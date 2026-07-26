class_name TestInteractable extends RigidBody3D

@onready var hover_label: Label3D = %HoverLabel
@onready var interaction_label: Label3D = %InteractionLabel

var interaction_handler : TestInteractionHandler = TestInteractionHandler.new(self)
