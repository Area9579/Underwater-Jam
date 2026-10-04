class_name TempGaugeControls extends ValveControl

@export var increment: TempControlButton
@export var decrement: TempControlButton
@export var target_label: Label3D
@export var current_label: Label3D

# these are min/max values based on celcius temps, 22.0*C is abt room temp
const MIN : float = 0.0
const MAX : float = 112.0
const VALUE_CHANGE_AMOUNT : float = (MAX - MIN) / 15

var curr_value : float = 0.0
var target_value : float = 0.0

func _ready() -> void:
	setup_values()
	#connect_signals()


func connect_signals() -> void:
	increment.pressed.connect(_on_increment_pressed)
	decrement.pressed.connect(_on_decrement_pressed)


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


func _on_increment_pressed() -> void:
	if player_won:
		return
	curr_value = clampf(curr_value + VALUE_CHANGE_AMOUNT, MIN, MAX)
	check_for_success()
	update_text()


func _on_decrement_pressed() -> void:
	if player_won:
		return
	curr_value = clampf(curr_value - VALUE_CHANGE_AMOUNT, MIN, MAX)
	check_for_success()
	update_text()


func update_text() -> void:
	current_label.text = "Temp: " + "%.1f" % curr_value
	
	if Utils.nearly_equal(curr_value, target_value, VALUE_CHANGE_AMOUNT):
		finish()
		return
	
	if curr_value > target_value:
		target_label.text = "WARNING: SPECIMEN TEMP\nEXCEEDS TARGET RANGE"
		target_label.modulate = Color.CRIMSON
		current_label.modulate = Color.CRIMSON
	else:
		target_label.text = "WARNING: SPECIMEN TEMP\nUNDER TARGET RANGE"
		target_label.modulate = Color.BLUE_VIOLET
		current_label.modulate = Color.BLUE_VIOLET


func check_for_success() -> void:
	if player_won:
		return
	if Utils.nearly_equal(curr_value, target_value, VALUE_CHANGE_AMOUNT):
		finish()


func finish() -> void:
	super()
	increment.interaction_handler.is_enabled = false
	decrement.interaction_handler.is_enabled = false
	target_label.text = "SPECIMEN TEMP\nMEETS TARGET RANGE"
	target_label.modulate = Color.LIGHT_GREEN
	current_label.modulate = Color.LIGHT_GREEN
	
