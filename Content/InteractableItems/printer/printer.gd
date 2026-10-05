class_name Printer extends Node3D


@onready var printer_event: Event = $PrinterEvent
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_event_enable() -> void:
	await get_tree().create_timer(0.1).timeout
	animation_player.play("UHGHG")
	await animation_player.animation_finished
	printer_event.finish()
