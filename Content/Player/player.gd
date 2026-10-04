class_name Player extends FirstPersonEntityController

@onready var sheet_marker: Marker3D = $Head/Camera3D/SheetMarker as Marker3D
@onready var footstep_player: AudioStreamPlayer = %FootstepPlayer
@onready var interaction_raycast: InteractionRaycast = %InteractionRaycast
@onready var hand_icon: TextureRect = %HandIcon
@onready var camera_3d: Camera3D = %Camera3D

const HAND_OPEN = preload("uid://d1bht2p36xbyw")
const HAND_CLOSED = preload("uid://disykxjnkewfx")


var has_sheet : bool = false
var sheet_equiped : bool = false


func _physics_process(_delta: float) -> void:
	# hide hand if colliding
	if !interaction_raycast.is_colliding():
		hand_icon.hide()
		return
	
	# error handling for var naming with interaction stuff
	if "interaction_handler" not in interaction_raycast.get_collider():
		push_warning("%s: Interaction handler is colliding with something on the interaction collision layer which has no variable name: `interaction_handler`" % self)
		hand_icon.hide()
		return
	
	# hide hand if the interactable is disabled
	if !(interaction_raycast.get_collider().interaction_handler as AbstractInteractionHandler).is_enabled:
		hand_icon.hide()
		return
	
	# toggle hand texture if player is actively interacting or not
	if Input.is_action_pressed("interact"):
		hand_icon.texture = HAND_CLOSED
		hand_icon.show()
	else:
		hand_icon.texture = HAND_OPEN
		hand_icon.show()


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
