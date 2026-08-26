class_name DNASegment extends Control
@onready var label: Label = $Label as Label


func update_dna_text(new_text : String) -> void:
	label.text = new_text
