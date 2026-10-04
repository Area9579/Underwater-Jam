class_name PhScaleLeverPanel extends ValveControl

# for translating to rotational values
const MIN_ROTATION : float = 0.0
const MAX_ROTATION : float = 90.0
const ROT_OFFSET : float = 45

const MIN : float = 0.0
const MAX : float = 14.0
const VALUE_CHANGE_AMOUNT : float = 1.0

@onready var ph_scale_lever: PhScaleLever = %PhScaleLever
@onready var target_label: Label3D = %TargetLabel
@onready var current_label: Label3D = %CurrentLabel

var curr_value : float = 0.0
var target_value : float = 0.0


func get_rotation_from_curr_value() -> float:
	# remap PH scale to rotation range defined by const values
	var inbetween : float = Utils.remap_with_clamp(curr_value, MIN, MAX, MIN_ROTATION + ROT_OFFSET, MAX_ROTATION + ROT_OFFSET)
	# flip scale to get roatation running in correct direction bc idek whats going on
	return remap(inbetween, MIN_ROTATION + ROT_OFFSET, MAX_ROTATION + ROT_OFFSET, MAX_ROTATION + ROT_OFFSET, MIN_ROTATION + ROT_OFFSET)

func _ready() -> void:
	setup_values()
	connect_signals()


func connect_signals() -> void:
	ph_scale_lever.value_changed.connect(_on_lever_dragged)


func get_rand_value_in_range() -> float:
	return randf_range(MIN, MAX)


func setup_values() -> void:
	curr_value = get_rand_value_in_range()
	target_value = get_rand_value_in_range()
	
	# haha fuck you edge case!
	if Utils.nearly_equal(curr_value, target_value, VALUE_CHANGE_AMOUNT * 2.0):
		setup_values()
		return
	
	update_text()


func _on_lever_dragged(value : float) -> void:
	curr_value = clampf(curr_value - (value * VALUE_CHANGE_AMOUNT), MIN, MAX)
	update_text()
	check_for_success()


func update_text() -> void:
	target_label.text = "Target: " + "%.1f" % target_value
	current_label.text = "Current: " + "%.1f" % curr_value
	ph_scale_lever.rotation.x = deg_to_rad(get_rotation_from_curr_value())


func check_for_success() -> void:
	if player_won:
		return
	if Utils.nearly_equal(curr_value, target_value, 0.05):
		finish()


func finish() -> void:
	super()
	ph_scale_lever.interaction_handler.is_enabled = false
	target_label.modulate = Color.GREEN
	current_label.modulate = Color.GREEN
	
