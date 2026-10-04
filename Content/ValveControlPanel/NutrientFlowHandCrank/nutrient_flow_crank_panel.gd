class_name NutrientFlowCrankPanel extends ValveControl

@export var nutrient_flow_crank: NutrientFlowCrank
@export var curr_location_path_follow: PathFollow3D
@export var target_location_path_follow: PathFollow3D
@export var curr_location_mesh: MeshInstance3D
@export var target_location_mesh: MeshInstance3D

const MIN : float = 0.0
const MAX : float = 1.0
const VALUE_CHANGE_AMOUNT : float = 0.1

func _ready() -> void:
	nutrient_flow_crank.value_changed.connect(_on_value_changed)


func get_rotation_from_curr_value() -> float:
	return Utils.remap_with_clamp(curr_location_path_follow.progress_ratio, MIN, MAX, 0, 360)


func _on_value_changed(value : float) -> void:
	if player_won:
		return
	curr_location_path_follow.progress_ratio = clampf(curr_location_path_follow.progress_ratio + (value * VALUE_CHANGE_AMOUNT), MIN, MAX)
	nutrient_flow_crank.rotation.y = deg_to_rad(get_rotation_from_curr_value())
	check_for_success()


func check_for_success() -> void:
	if player_won:
		return
	if Utils.nearly_equal(curr_location_path_follow.progress_ratio, target_location_path_follow.progress_ratio, 0.01):
		finish()


func finish() -> void:
	target_location_mesh.hide()
	nutrient_flow_crank.interaction_handler.is_enabled = false
	super()
