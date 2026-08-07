class_name ComputerButton extends Area3D

@onready var node_3d_tween_sequencer: Node3DTweenSequencer = $Node3DTweenSequencer as Node3DTweenSequencer
@onready var label_3d: Label3D = $Label3D


var interaction_handler : ComputerButtonInteractionHandler = ComputerButtonInteractionHandler.new(self)


func play_button_tween() -> void:
	node_3d_tween_sequencer.stop_sequence()
	node_3d_tween_sequencer.do_tween_sequence()
