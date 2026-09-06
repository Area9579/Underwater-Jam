class_name DNASegment extends Control
@onready var dna_texture: TextureRect = $DNATexture as TextureRect


func set_dna_texture(new_texture : CompressedTexture2D) -> void:
	dna_texture.texture = new_texture
