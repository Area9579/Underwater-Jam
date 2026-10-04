class_name NutrientFlowCrankPanel extends ValveControl

@export var nutrient_flow_crank: NutrientFlowCrank
@export var curr_display_mesh : MeshInstance3D
@export var target_display_mesh : MeshInstance3D

const MIN : float = 100.0
const MAX : float = 175.0
const VALUE_CHANGE_AMOUNT : float = 5.0

const MIN_ROT : float = 0
const MAX_ROT : float = 270
const ROT_OFFSET : float = -45 + 180

var curr_value : float
var target_value : float

func _ready() -> void:
	nutrient_flow_crank.value_changed.connect(_on_value_changed)
	setup_values()


func get_rot_from_value(value : float) -> float:
	return deg_to_rad(Utils.remap_with_clamp(value, MIN, MAX, MIN_ROT + ROT_OFFSET, MAX_ROT+ ROT_OFFSET))


func setup_values() -> void:
	curr_value = randf_range(MIN, MAX)
	target_value = randf_range(MIN, MAX)
	

	# haha fuck you edge case!
	if Utils.nearly_equal(curr_value, target_value, VALUE_CHANGE_AMOUNT * 5):
		setup_values()
		return
	update_display()


func _on_value_changed(value : float) -> void:
	if player_won:
		return
	curr_value = clampf(curr_value - (value * VALUE_CHANGE_AMOUNT), MIN, MAX)
	
	check_for_success()
	update_display()


func update_display() -> void:
	# update crank rotation
	nutrient_flow_crank.parent_mesh.rotation.y = get_rot_from_value(curr_value)
	# update display rotation
	target_display_mesh.rotation.y = get_rot_from_value(target_value)
	curr_display_mesh.rotation.y = get_rot_from_value(curr_value)


func check_for_success() -> void:
	if player_won:
		return
	if Utils.nearly_equal(curr_value, target_value, VALUE_CHANGE_AMOUNT / 5.0):
		finish()


func finish() -> void:
	target_display_mesh.hide()
	nutrient_flow_crank.interaction_handler.is_enabled = false
	super()
