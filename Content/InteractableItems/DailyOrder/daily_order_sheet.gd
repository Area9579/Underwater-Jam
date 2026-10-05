class_name DailyOrderSheet extends Area3D

@onready var daily_order_event: Event = $DailyOrdertEvent
@onready var put_down: Node3DTween = $PutDown
@onready var pull_up: Node3DTween = $PullUp

var interaction_handler : DailyOrderInteractionHandler = DailyOrderInteractionHandler.new(self)



func _ready() -> void:
	daily_order_event.event_enabled.connect(_on_event_enable)
	daily_order_event.event_disabled.connect(_on_event_disable)



func _on_event_enable() -> void:
	self.set_collision_layer_value(4, true)
	interaction_handler.enable()


func _on_event_disable() -> void:
	self.set_collision_layer_value(4, false)
	interaction_handler.disable()
