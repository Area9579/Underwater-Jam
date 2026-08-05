class_name Player extends FirstPersonEntityController

@onready var sheet_marker: Marker3D = $Head/Camera3D/SheetMarker as Marker3D
@onready var hand_icon: TextureRect = $CanvasLayer/PanelContainer/HandIcon as TextureRect
@onready var interaction_raycast: InteractionRaycast = %InteractionRaycast

const HAND_OPEN = preload("uid://d1bht2p36xbyw")
const HAND_CLOSED = preload("uid://disykxjnkewfx")


var has_sheet : bool = false
var sheet_equiped : bool = false


func _process(_delta: float) -> void:
	if interaction_raycast.is_colliding() and Input.is_action_pressed("interact"):
		hand_icon.texture = HAND_CLOSED
		hand_icon.show()
	elif interaction_raycast.is_colliding():
		hand_icon.texture = HAND_OPEN
		hand_icon.show()
	else:
		hand_icon.hide()


func _input(event: InputEvent) -> void:
	super(event)
	if event.is_action_pressed("equip") and interaction_enabled and has_sheet:
		change_sheet_equip()



func change_sheet_equip() -> void:
	match sheet_equiped:
		true:
			sheet_equiped = false
			sheet_marker.visible = false
		false:
			sheet_equiped = true
			sheet_marker.visible = true
