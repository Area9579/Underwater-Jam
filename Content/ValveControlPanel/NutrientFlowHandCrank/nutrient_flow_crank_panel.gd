class_name NutrientFlowCrankPanel extends ValveControl

@onready var nutrient_flow_crank: NutrientFlowCrank = %NutrientFlowCrank
@onready var curr_location_path_follow: PathFollow3D = %CurrLocationPathFollow
@onready var target_location_path_follow: PathFollow3D = %TargetLocationPathFollow
@onready var curr_location_mesh: MeshInstance3D = %CurrLocationMesh
@onready var target_location_mesh: MeshInstance3D = %TargetLocationMesh

const MIN : float = 0.0
const MAX : float = 1.0
const VALUE_CHANGE_AMOUNT : float = 0.01


func _ready() -> void:
	nutrient_flow_crank.increment_value.connect(_on_nutrient_flow_crank_clockwise)
	nutrient_flow_crank.decrement_value.connect(_on_nutrient_flow_crank_counter_clockwise)


func _on_nutrient_flow_crank_clockwise() -> void:
	if player_won:
		return
	curr_location_path_follow.progress_ratio = clampf(curr_location_path_follow.progress_ratio + VALUE_CHANGE_AMOUNT, MIN, MAX)
	check_for_success()


func _on_nutrient_flow_crank_counter_clockwise() -> void:
	if player_won:
		return
	curr_location_path_follow.progress_ratio = clampf(curr_location_path_follow.progress_ratio - VALUE_CHANGE_AMOUNT, MIN, MAX)
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
