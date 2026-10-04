class_name ComputerScreen extends Control

const DNA_SEGMENT = preload("uid://j1da4awngyhk")


signal fuck_go_back

var enabled : bool = false


## Tween stuff for button UI
@onready var left_arrow_tween: ControlTweenSequencer = %LeftArrowTween as ControlTweenSequencer
@onready var right_arrow_tween: ControlTweenSequencer = %RightArrowTween as ControlTweenSequencer

@onready var left_move: ControlTween = %LeftMove as ControlTween
@onready var right_move: ControlTween = %RightMove as ControlTween
@onready var sqoosh: ControlTween = $HBoxContainer2/SelectedDNAIcon/Sqoosh as ControlTween


func _ready() -> void:
	left_move.tween_finished.connect(play_squoosh)
	right_move.tween_finished.connect(play_squoosh)


func _process(_delta: float) -> void:
	if !enabled:
		return
	
	if Input.is_action_just_pressed("right"):
		right_arrow_tween.do_tween_sequence()
	elif Input.is_action_just_pressed("left"):
		left_arrow_tween.do_tween_sequence()
	
	if Input.is_action_just_pressed("alt_interact"):
		fuck_go_back.emit()


func play_squoosh() -> void:
	sqoosh.do_tween()


func add_new_dna_segment(new_texture: CompressedTexture2D) -> void:
	var new_dna : DNASegment = DNA_SEGMENT.instantiate() as DNASegment
	new_dna.set_dna_texture(new_texture)
