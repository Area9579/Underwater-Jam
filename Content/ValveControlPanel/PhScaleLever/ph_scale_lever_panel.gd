class_name PhScaleLeverPanel extends ValveControl

# for translating to rotational values
const MIN_ROTATION : float = 0.0
const MAX_ROTATION : float = 70.0
const ROT_OFFSET : float = -(20 + 90)

const MIN : float = 0.0
const MAX : float = 14.0
const VALUE_CHANGE_AMOUNT : float = 1.0

@export var ph_scale_lever: PhScaleLever

@export var curr_location_path_follow: PathFollow3D
@export var target_location_path_follow: PathFollow3D
@export var curr_location_mesh: MeshInstance3D
@export var target_location_mesh: MeshInstance3D

func get_rotation_from_curr_value() -> float:
	# remap PH scale to rotation range defined by const values
	var raw_rot_value : float = Utils.remap_with_clamp(curr_location_path_follow.progress_ratio, 0.0, 1.0, MIN_ROTATION + ROT_OFFSET, MAX_ROTATION + ROT_OFFSET)
	# flip scale to get roatation running in correct direction bc idek whats going on
	return raw_rot_value#remap(raw_rot_value, MIN_ROTATION + ROT_OFFSET, MAX_ROTATION + ROT_OFFSET, MAX_ROTATION + ROT_OFFSET, MIN_ROTATION + ROT_OFFSET)

func _ready() -> void:
	setup_values()
	connect_signals()


func _on_event_event_disabled() -> void:
	ph_scale_lever.interaction_handler.disable()
	target_location_mesh.hide()



func _on_event_event_enabled() -> void:
	ph_scale_lever.interaction_handler.enable()
	target_location_mesh.show()



func connect_signals() -> void:
	ph_scale_lever.value_changed.connect(_on_lever_dragged)


func get_rand_value_in_range() -> float:
	return randf_range(MIN, MAX)


func setup_values() -> void:
	var curr_value : float = get_rand_value_in_range()
	var target_value  : float = get_rand_value_in_range()
	

	# haha fuck you edge case!
	if Utils.nearly_equal(curr_value, target_value, VALUE_CHANGE_AMOUNT * 2.0):
		setup_values()
		return
	
	curr_location_path_follow.progress_ratio = Utils.remap_with_clamp(curr_value, MIN, MAX, 0.0, 1.0)
	target_location_path_follow.progress_ratio = Utils.remap_with_clamp(target_value, MIN, MAX, 0.0, 1.0)
	update_lever_location()


func _on_lever_dragged(value : float) -> void:
	curr_location_path_follow.progress_ratio = clampf(curr_location_path_follow.progress_ratio - (value * VALUE_CHANGE_AMOUNT), 0.0, 1.0)
	update_lever_location()
	check_for_success()



func update_lever_location() -> void:
	ph_scale_lever.parent_mesh.rotation.z = deg_to_rad(get_rotation_from_curr_value())
	


func check_for_success() -> void:
	if player_won:
		return
	if Utils.nearly_equal(curr_location_path_follow.progress_ratio, target_location_path_follow.progress_ratio, 0.05):
		finish()


func finish() -> void:
	super()
	ph_scale_lever.interaction_handler.is_enabled = false
	target_location_mesh.visible = false
	
