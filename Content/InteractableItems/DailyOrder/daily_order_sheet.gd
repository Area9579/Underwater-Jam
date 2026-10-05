class_name DailyOrderSheet extends Area3D

const TELEX_ORDER_1 = preload("uid://cwdmfove3sqv")
const TELEX_ORDER_2 = preload("uid://dt8mtgw3b812p")
const TELEX_ORDER_3 = preload("uid://bdyr2p2aty8u2")
const TELEX_ORDER_4 = preload("uid://lhwubfq28mmq")
const TELEX_ORDER_5 = preload("uid://s86vs4ih0epp")

@onready var daily_order_event: Event = $DailyOrdertEvent
@onready var put_down: Node3DTween = $PutDown
@onready var pull_up: Node3DTween = $PullUp
@onready var sprite_3d: Sprite3D = $Sprite3D

var interaction_handler : DailyOrderInteractionHandler = DailyOrderInteractionHandler.new(self)



func _ready() -> void:
	daily_order_event.event_enabled.connect(_on_event_enable)
	daily_order_event.event_disabled.connect(_on_event_disable)


func set_texture(new_texture : Texture2D) -> void:
	sprite_3d.texture = new_texture


func _on_event_enable() -> void:
	self.set_collision_layer_value(4, true)
	interaction_handler.enable()


func _on_event_disable() -> void:
	self.set_collision_layer_value(4, false)
	interaction_handler.disable()
