class_name DNASegment extends Control

@onready var row_1_left: TextureRect = $Row1Left
@onready var row_2_left: TextureRect = $Row2Left
@onready var row_3_left: TextureRect = $Row3Left
@onready var row_4_left: TextureRect = $Row4Left

@onready var row_1_right: TextureRect = $Row1Right
@onready var row_2_right: TextureRect = $Row2Right
@onready var row_3_right: TextureRect = $Row3Right
@onready var row_4_right: TextureRect = $Row4Right

@onready var left_array : Array[TextureRect] = [row_1_left, row_2_left, row_3_left, row_4_left]


func _ready() -> void:
	print(left_array)


func set_dna_texture(new_texture : CompressedTexture2D) -> void:
	dna_texture.texture = new_texture
