extends Node3D


@onready var hand_crank: HandCrank = %HandCrank
@onready var progress_bar: ProgressBar = %ProgressBar


const MIN : float = 0.0
const MAX : float = 1.0
const VALUE_CHANGE_AMOUNT : float = 0.1

func _ready() -> void:
	hand_crank.increment_value.connect(_on_hand_crank_clockwise)
	hand_crank.decrement_value.connect(_on_hand_crank_counter_clockwise)


func _on_hand_crank_clockwise() -> void:
	progress_bar.value = clamp(progress_bar.value + VALUE_CHANGE_AMOUNT, progress_bar.min_value, progress_bar.max_value)



func _on_hand_crank_counter_clockwise() -> void:
	progress_bar.value = clamp(progress_bar.value - VALUE_CHANGE_AMOUNT, progress_bar.min_value, progress_bar.max_value)
