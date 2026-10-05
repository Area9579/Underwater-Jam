class_name DNASegment extends Control

const DNA_BAR_RED = preload("uid://djj4p65gqvltm")
const DNA_BAR_CYAN = preload("uid://clwmkwelv25wn")
const DNA_BAR_GREEN = preload("uid://b4s0sl550ras5")
const DNA_BAR_ORANGE = preload("uid://dgfpofreertcu")
const DNA_BAR_PURPLE = preload("uid://b37swiii21c5i")
const DNA_BAR_YELLOW = preload("uid://ckgeog8y5n6ak")

@onready var row_1_left: TextureRect = $Row1Left
@onready var row_2_left: TextureRect = $Row2Left
@onready var row_3_left: TextureRect = $Row3Left
@onready var row_4_left: TextureRect = $Row4Left

@onready var row_1_right: TextureRect = $Row1Right
@onready var row_2_right: TextureRect = $Row2Right
@onready var row_3_right: TextureRect = $Row3Right
@onready var row_4_right: TextureRect = $Row4Right

@onready var left_array : Array[TextureRect] = [row_1_left, row_2_left, row_3_left, row_4_left]
@onready var right_array : Array[TextureRect] = [row_1_right, row_2_right, row_3_right, row_4_right]

var dna_index : int = 0


func _ready() -> void:
	set_dna_password("OYGB")
	reset_right_segments()


func set_dna_password(dna_string : String) -> void:
	if dna_string.length() != 4: return
	
	for i in range(dna_string.length()) :
		match_char_to_dna(dna_string[i], left_array[i])


func set_next_segment(next_texture : Texture2D) -> void:
	right_array[dna_index].texture = next_texture
	dna_index += 1


func reset_right_segments() -> void:
	dna_index = 0
	for element : TextureRect in right_array:
		element.texture = null


func match_char_to_dna(character : String, texture : TextureRect) -> void:
	match character:
		"R":
			texture.texture = DNA_BAR_RED
		"O":
			texture.texture = DNA_BAR_ORANGE
		"Y":
			texture.texture = DNA_BAR_YELLOW
		"G":
			texture.texture = DNA_BAR_GREEN
		"B":
			texture.texture = DNA_BAR_CYAN
		"P":
			texture.texture = DNA_BAR_PURPLE


func set_dna_texture(new_texture : CompressedTexture2D) -> void:
	var dna_texture : TextureRect = left_array[0]
	dna_texture.texture = new_texture
