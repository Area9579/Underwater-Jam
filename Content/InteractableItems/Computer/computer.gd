class_name Computer extends Node3D

@export var event : Event

@onready var computer_button: ComputerButton = $ComputerButton as ComputerButton
@onready var computer_button_2: ComputerButton = $ComputerButton2 as ComputerButton
@onready var computer_button_3: ComputerButton = $ComputerButton3 as ComputerButton
@onready var computer_button_4: ComputerButton = $ComputerButton4 as ComputerButton
@onready var computer_button_5: ComputerButton = $ComputerButton5 as ComputerButton
@onready var computer_button_6: ComputerButton = $ComputerButton6 as ComputerButton

@onready var label_3d: Label3D = $Label3D as Label3D
@onready var computer_screen: ComputerScreen = $SubViewport/ComputerScreen as ComputerScreen

var computer_button_arr : Array[ComputerButton]

const max_inputs : int = 6
var goal_password : String = 'ROYGBP'
var current_password : String = ''

func _ready() -> void:
	computer_button_arr = [
		computer_button,
		computer_button_2,
		computer_button_3,
		computer_button_4,
		computer_button_5,
		computer_button_6,
	]
	
	for button in computer_button_arr:
		button.button_pressed.connect(add_value_to_string)




func add_value_to_string(new_input : String, new_texture : CompressedTexture2D) -> void:
	if current_password.length() < max_inputs:
		current_password += new_input
		print(current_password)
		computer_screen.add_new_dna_segment(new_texture)
	if current_password == goal_password:
		event.finish()
	elif (current_password.length() == max_inputs) or (current_password[current_password.length() - 1] == goal_password[current_password.length() - 1]):
		print('reset')


func _on_event_event_disabled() -> void:
	for button in computer_button_arr:
		button.interaction_handler.disable()


func _on_event_event_enabled() -> void:
	for button in computer_button_arr:
		button.interaction_handler.enable()
