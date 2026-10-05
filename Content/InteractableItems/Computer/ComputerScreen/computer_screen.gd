class_name ComputerScreen extends Control

const DNA_BAR_RED = preload("uid://djj4p65gqvltm")
const DNA_BAR_ORANGE = preload("uid://dgfpofreertcu")
const DNA_BAR_YELLOW = preload("uid://ckgeog8y5n6ak")
const DNA_BAR_GREEN = preload("uid://b4s0sl550ras5")
const DNA_BAR_CYAN = preload("uid://clwmkwelv25wn")
const DNA_BAR_PURPLE = preload("uid://b37swiii21c5i")


signal fuck_go_back

var enabled : bool = false

## Tween stuff for button UI
@onready var left_arrow_tween: ControlTweenSequencer = %LeftArrowTween as ControlTweenSequencer
@onready var right_arrow_tween: ControlTweenSequencer = %RightArrowTween as ControlTweenSequencer

@onready var left_move: ControlTween = %LeftMove as ControlTween
@onready var right_move: ControlTween = %RightMove as ControlTween
@onready var sqoosh: ControlTween = $HBoxContainer2/SelectedDNAIcon/Sqoosh as ControlTween
@onready var selected_dna_icon: TextureRect = $HBoxContainer2/SelectedDNAIcon

@onready var dna_segment: DNASegment = $HBoxContainer/ColorRect2/HBoxContainer/DNASegment


@onready var color_arr : Array[Texture2D] = [DNA_BAR_RED, DNA_BAR_ORANGE, DNA_BAR_YELLOW,DNA_BAR_GREEN, DNA_BAR_CYAN, DNA_BAR_PURPLE]
@onready var current_color : Texture2D = DNA_BAR_RED

var sequence : String = 'OYGB'
var password : String = "BPGO"
var current_pass : String = ""

signal all_done_here_boss


func _ready() -> void:
	left_move.tween_finished.connect(play_squoosh)
	right_move.tween_finished.connect(play_squoosh)
	
	dna_segment.set_dna_password(sequence)


func _process(_delta: float) -> void:
	if !enabled:
		return
	
	if Input.is_action_just_pressed("right"):
		increment_right()
		right_arrow_tween.do_tween_sequence()
	elif Input.is_action_just_pressed("left"):
		increment_left()
		left_arrow_tween.do_tween_sequence()
	
	if Input.is_action_just_pressed("alt_interact"):
		fuck_go_back.emit()
	
	if Input.is_action_just_pressed("enter"):
		password_check()
		play_squoosh()



func password_check() -> void:
	if texture_to_pass_conversion() == "" : return
	
	current_pass += texture_to_pass_conversion()
	if current_pass.substr(0, current_pass.length()) != password.substr(0, current_pass.length()):
		current_pass = ""
		dna_segment.reset_right_segments()
		return
	
	dna_segment.set_next_segment(current_color)
	if current_pass == password:
		all_done_here_boss.emit()
		return


func texture_to_pass_conversion() -> String:
	match current_color:
		DNA_BAR_RED:
			return "R"
		DNA_BAR_ORANGE:
			return "O"
		DNA_BAR_YELLOW:
			return "Y"
		DNA_BAR_GREEN:
			return "G"
		DNA_BAR_CYAN:
			return "B"
		DNA_BAR_PURPLE:
			return "P"
	return ""


func play_squoosh() -> void:
	sqoosh.do_tween()
	selected_dna_icon.texture = current_color


func increment_right() -> void:
	if color_arr.find(current_color) == (color_arr.size() - 1):
		current_color = color_arr[0]
	else:
		current_color = color_arr[color_arr.find(current_color) + 1]


func increment_left() -> void:
	if color_arr.find(current_color) == 0:
		current_color = color_arr[color_arr.size() - 1]
	else:
		current_color = color_arr[color_arr.find(current_color) - 1]
	
