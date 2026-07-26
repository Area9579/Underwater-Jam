class_name TestInteractable extends RigidBody3D

@onready var label_3d: Label3D = %Label3D

var interaction_handler : TestInteractionHandler = TestInteractionHandler.new(self)
