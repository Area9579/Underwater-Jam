class_name DailyOrderSheet extends Area3D

@onready var test_label: Label3D = $TestLabel as Label3D #NOTE: to be removed after testing

var interaction_handler : DailyOrderInteractionHandler = DailyOrderInteractionHandler.new(self)
