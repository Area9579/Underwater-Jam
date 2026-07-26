extends Node3D

@onready var player: Player = %Player
@onready var state_status_text: RichTextLabel = %StateStatusText


func _ready() -> void:
	state_status_text.text = ""
	state_status_text.text += "Look enabled: " + str(player.look_enabled)
	state_status_text.text += "\nMove enabled: " + str(player.movement_enabled)
	state_status_text.text += "\nInteract enabled: " + str(player.interaction_enabled)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# 'E' key
	if Input.is_action_just_pressed("debug_toggle"):
		player.look_enabled = !player.look_enabled
		player.movement_enabled = !player.movement_enabled
		player.interaction_enabled = !player.interaction_enabled
		state_status_text.text = ""
		state_status_text.text += "Look enabled: " + str(player.look_enabled)
		state_status_text.text += "\nMove enabled: " + str(player.movement_enabled)
		state_status_text.text += "\nInteract enabled: " + str(player.interaction_enabled)
