class_name HandCrankControl extends ValveControl

@onready var hand_crank: HandCrank = %HandCrank
@onready var curr_location_path_follow: PathFollow3D = %CurrLocationPathFollow
@onready var target_location_path_follow: PathFollow3D = %TargetLocationPathFollow
@onready var curr_location_mesh: MeshInstance3D = %CurrLocationMesh
@onready var target_location_mesh: MeshInstance3D = %TargetLocationMesh

const MIN : float = 0.0
const MAX : float = 1.0
const VALUE_CHANGE_AMOUNT : float = 0.01


func _ready() -> void:
	hand_crank.increment_value.connect(_on_hand_crank_clockwise)
	hand_crank.decrement_value.connect(_on_hand_crank_counter_clockwise)


func _on_hand_crank_clockwise() -> void:
	if player_won:
		return
	curr_location_path_follow.progress_ratio = clampf(curr_location_path_follow.progress_ratio + VALUE_CHANGE_AMOUNT, MIN, MAX)
	check_for_success()


func _on_hand_crank_counter_clockwise() -> void:
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
	hand_crank.interaction_handler.is_enabled = false
	super()
