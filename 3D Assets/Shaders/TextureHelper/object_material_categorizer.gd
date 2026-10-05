class_name ObjectMaterialCategorizer extends Node

@export var objects : Array[MeshInstance3D]
@export var material_holder : MaterialHolder


static func set_to_xray(categorizers : Array[ObjectMaterialCategorizer]) -> void:
	print('setting to xray: ', categorizers)
	for categorizer in categorizers:
		if categorizer == null:
			continue
		categorizer.set_to_xray_material()


static func set_to_default(categorizers : Array[ObjectMaterialCategorizer]) -> void:
	print('setting to default: ', categorizers)
	for categorizer in categorizers:
		if categorizer == null:
			continue
		categorizer.set_to_default_material()


func set_to_xray_material() -> void:
	for object in objects:
		if object == null:
			continue
		object.material_override = material_holder.xray_material


func set_to_default_material() -> void:
	for object in objects:
		if object == null:
			continue
		object.material_override = material_holder.default_material
