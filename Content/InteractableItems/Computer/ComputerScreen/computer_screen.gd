class_name ComputerScreen extends Control
@onready var dna_segment: DNASegment = $HBoxContainer/ColorRect2/HBoxContainer/DNARight/DNASegment as DNASegment

func _ready() -> void:
	dna_segment.update_dna_text('')
