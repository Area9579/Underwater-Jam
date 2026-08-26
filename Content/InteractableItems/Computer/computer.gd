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
var goal_input : String = 'ROYGBP'

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


func add_value_to_string(new_input : String) -> void:
	if computer_screen.dna_segment.label.text.length() < max_inputs:
		#label_3d.text = label_3d.text + new_input
		computer_screen.dna_segment.update_dna_text(computer_screen.dna_segment.label.text + new_input)
	if computer_screen.dna_segment.label.text == goal_input:
		computer_screen.dna_segment.label.text = 'COMPLETED'
		event.finish()
	elif computer_screen.dna_segment.label.text.length() == max_inputs:
		computer_screen.dna_segment.label.text = 'RESET'
		await get_tree().create_timer(0.5).timeout
		computer_screen.dna_segment.label.text = ''


func _on_event_event_disabled() -> void:
	for button in computer_button_arr:
		button.interaction_handler.disable()


func _on_event_event_enabled() -> void:
	for button in computer_button_arr:
		button.interaction_handler.enable()
