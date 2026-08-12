class_name ComputerButton extends Area3D

signal button_pressed(value : String)

@onready var node_3d_tween_sequencer: Node3DTweenSequencer = $Node3DTweenSequencer as Node3DTweenSequencer
@onready var hover_text_label: Label3D = $HoverText as Label3D

@export var hover_text : String
@export var value : String

var interaction_handler : ComputerButtonInteractionHandler = ComputerButtonInteractionHandler.new(self)


func _ready() -> void:
	hover_text_label.text = hover_text


func play_button_tween() -> void:
	node_3d_tween_sequencer.stop_sequence()
	node_3d_tween_sequencer.do_tween_sequence()


func button_press() -> void:
	button_pressed.emit(value)
