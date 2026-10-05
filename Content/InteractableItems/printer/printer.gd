class_name Printer extends Node3D


@onready var printer_event: Event = $PrinterEvent
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _ready() -> void:
	pass



func _on_event_enable() -> void:
	animation_player.play("UHGHG")
	printer_event.finish()
