class_name Computer extends Node3D

@export var event : Event

@onready var computer_screen: ComputerScreen = $SubViewport/ComputerScreen as ComputerScreen
@onready var marker_3d: Marker3D = $Marker3D
@onready var area_3d: ComputerInteractable = $Area3D

const max_inputs : int = 6
var goal_password : String = 'ROYGBP'
var current_password : String = ''

var computer_enabled : bool = false

var player_camera : Camera3D

func _ready() -> void:
	area_3d.interaction_handler.send_player_camera.connect(tween_camera_to_lock)
	computer_screen.fuck_go_back.connect(go_back)


func go_back() -> void:
	computer_screen.enabled = false
	var cam_tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	cam_tween.tween_property(player_camera, "position", Vector3(0.0, 0.51, 0.0), 0.8)
	cam_tween.tween_property(player_camera, "rotation_degrees", Vector3(0.0, 0.0, 0.0), 0.8)
	player_camera.get_parent().get_parent().interaction_enabled = true
	player_camera.get_parent().get_parent().look_enabled = true
	player_camera.get_parent().get_parent().movement_enabled = true


func tween_camera_to_lock(camera : Camera3D) -> void:
	computer_screen.enabled = true
	player_camera = camera
	var camera_tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	camera_tween.tween_property(player_camera, "global_position", marker_3d.global_position, 0.8)
	camera_tween.tween_property(player_camera, "global_rotation_degrees", marker_3d.global_rotation_degrees, 0.8)
	


func add_value_to_string(new_input : String, new_texture : CompressedTexture2D) -> void:
	if current_password.length() < max_inputs:
		current_password += new_input
		print(current_password)
		computer_screen.add_new_dna_segment(new_texture)
	if current_password == goal_password:
		event.finish()
	elif (current_password.length() == max_inputs) or (current_password[current_password.length() - 1] == goal_password[current_password.length() - 1]):
		print('reset')


func _on_event_event_disabled() -> void:
	computer_enabled = false
	pass


func _on_event_event_enabled() -> void:
	computer_enabled = true
	pass
