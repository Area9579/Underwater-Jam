class_name ComputerScreen extends Control

const DNA_SEGMENT = preload("uid://j1da4awngyhk")

@onready var dna_right: VBoxContainer = $HBoxContainer/ColorRect2/HBoxContainer/DNARight as VBoxContainer



func add_new_dna_segment(new_texture: CompressedTexture2D) -> void:
	var new_dna : DNASegment = DNA_SEGMENT.instantiate() as DNASegment
	dna_right.add_child(new_dna)
	new_dna.set_dna_texture(new_texture)
