class_name Player extends FirstPersonEntityController

@onready var sheet_marker: Marker3D = $Head/Camera3D/SheetMarker as Marker3D


var has_sheet : bool = false
var sheet_equiped : bool = false


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
