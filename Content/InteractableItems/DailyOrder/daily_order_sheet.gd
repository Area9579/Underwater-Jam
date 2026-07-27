class_name DailyOrderSheet extends Node3D

@onready var test_label: Label3D = $TestLabel as Label3D #NOTE: to be removed after testing

var daily_order_interaction_handler : DailyOrderInteractionHandler = DailyOrderInteractionHandler.new(self)
