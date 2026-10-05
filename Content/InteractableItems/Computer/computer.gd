class_name Computer extends Node3D

@export var event : Event

@onready var computer_screen: ComputerScreen = $SubViewport/ComputerScreen as ComputerScreen
@onready var marker_3d: Marker3D = $Marker3D
@onready var area_3d: ComputerInteractable = $Area3D
@onready var computer_event: Event = $ComputerEvent

var computer_enabled : bool = false

var player_camera : Camera3D

func _ready() -> void:
	area_3d.interaction_handler.send_player_camera.connect(tween_camera_to_lock)
	computer_screen.fuck_go_back.connect(go_back)
	computer_screen.all_done_here_boss.connect(call_finished)


func go_back() -> void:
	computer_screen.enabled = false
	var cam_tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	cam_tween.tween_property(player_camera, "position", Vector3(0.0, 0.51, 0.0), 0.8)
	cam_tween.tween_property(player_camera, "rotation_degrees", Vector3(0.0, 0.0, 0.0), 0.8)
	player_camera.get_parent().get_parent().interaction_enabled = true
	player_camera.get_parent().get_parent().look_enabled = true
	player_camera.get_parent().get_parent().movement_enabled = true


func tween_camera_to_lock(camera : Camera3D) -> void:
	if computer_enabled == false: return
	computer_screen.enabled = true
	player_camera = camera
	var camera_tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	camera_tween.tween_property(player_camera, "global_position", marker_3d.global_position, 0.8)
	camera_tween.tween_property(player_camera, "global_rotation_degrees", marker_3d.global_rotation_degrees, 0.8)


func call_finished() -> void:
	go_back()
	computer_event.finish()


func _on_event_event_disabled() -> void:
	computer_enabled = false
	area_3d.interaction_handler.puter_is_active = false
	area_3d.interaction_handler.disable()
	pass


func _on_event_event_enabled() -> void:
	computer_enabled = true
	area_3d.interaction_handler.puter_is_active = true
	area_3d.interaction_handler.enable()
	pass
