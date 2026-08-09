class_name Computer extends Node3D

@onready var computer_button: ComputerButton = $ComputerButton as ComputerButton
@onready var computer_button_2: ComputerButton = $ComputerButton2 as ComputerButton
@onready var computer_button_3: ComputerButton = $ComputerButton3 as ComputerButton
@onready var label_3d: Label3D = $Label3D as Label3D

const max_inputs : int = 3
var goal_input : String = 'ABC'

func _ready() -> void:
	computer_button.button_pressed.connect(add_value_to_string)
	computer_button_2.button_pressed.connect(add_value_to_string)
	computer_button_3.button_pressed.connect(add_value_to_string)



func add_value_to_string(new_input : String) -> void:
	if label_3d.text.length() < max_inputs:
		label_3d.text = label_3d.text + new_input
	if label_3d.text == goal_input:
		label_3d.text = 'COMPLETED'
	elif label_3d.text.length() == max_inputs:
		label_3d.text = 'RESET'
		await get_tree().create_timer(0.5).timeout
		label_3d.text = ''
