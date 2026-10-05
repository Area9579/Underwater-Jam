class_name Specimen_Controller extends Node3D

@warning_ignore("unused_signal")
signal specimen_good
@warning_ignore("unused_signal")
signal specimen_neutral
@warning_ignore("unused_signal")
signal specimen_bad

## Total length in seconds of every state change tween
const TWEEN_DURATION: float = 1.0

@onready var _specimen_timer: Timer = $Timer
@onready var _door_button: Door = $DoorButton

var _specimen: Node3D
## Surface material override on the specimen, set in _ready
var material: ShaderMaterial
## True after the first timer cycle completes
var _neutral_status: bool = false
var _good_status: bool = false

## Specimen mesh 

enum SpecimenState {
	GOOD,
	NEUTRAL,
	BAD
}

## Shader colors per state. "one" is the lightest band (color1), "four" is the darkest band (color4)
var good_color_one: Color = Color(0.459, 0.973, 0.663, 1.0)
var good_color_four: Color = Color(0.2, 0.459, 0.294, 1.0) 

var neutral_color_one: Color = Color(0.973, 0.845, 0.459, 1.0)
var neutral_color_four: Color = Color(0.459, 0.386, 0.2, 1.0)

var bad_color_one: Color = Color(0.973, 0.459, 0.459, 1.0)
var bad_color_four: Color = Color(0.459, 0.2, 0.209, 1.0)

func _ready() -> void:
	if has_node("Specimen2"):
		## Prod
		_specimen = $Specimen2
		material = _find_mesh_material(_specimen)
	else:
		## Gym
		_specimen = $Specimen
		material = _specimen.get_surface_override_material(0)
	
	_door_button.light_status.connect(_light_changed)
	_specimen_timer.timeout.connect(_timer_finished)
	
	## Start the timer, then pause it so it only counts down while the light is on
	_specimen_timer.start(5.0)
	_specimen_timer.paused = true
	
	## Specimen starts in the BAD state
	material.set_shader_parameter("color1", bad_color_one)
	material.set_shader_parameter("color4", bad_color_four)
	
	self.specimen_bad.emit()

## timer debug
func _process(_delta: float) -> void:
	#print(_specimen_timer.time_left)
	pass

func _find_mesh_material(node: Node) -> Material:
	if node.get_child_count() == 0:
		return null
	var child := node.get_child(0)
	if child is MeshInstance3D:
		return child.get_surface_override_material(0)
	return _find_mesh_material(child)

## Light on resumes the timer, light off pauses it (time left is kept)
func _light_changed(new_light_status: bool):
	if new_light_status && not _good_status:
		_specimen_timer.paused = false
	elif not new_light_status && not _good_status:
		_specimen_timer.paused = true
	else:
		## minigame finished
		pass

## First timeout moves BAD to NEUTRAL, second moves NEUTRAL to GOOD
func _timer_finished():
	if _neutral_status && not _good_status:
		_specimen_change_state(SpecimenState.GOOD)
		self.specimen_good.emit()
		#print("good")
	else:
		self.specimen_neutral.emit()
		_specimen_change_state(SpecimenState.NEUTRAL)
		_neutral_status = true
		_specimen_timer.start(5.0)
		#print("neutral")

## Starts all transition tweens for the new state; they run in parallel
func _specimen_change_state(new_specimen_state: SpecimenState):
	if new_specimen_state == SpecimenState.GOOD:
		_play_color_one(neutral_color_one, good_color_one)
		_play_color_four(neutral_color_four, good_color_four)
	elif new_specimen_state == SpecimenState.NEUTRAL:
		_play_color_one(bad_color_one, neutral_color_one)
		_play_color_four(bad_color_four, neutral_color_four)
	
	## Size and color intensity pulse on every state change
	_play_size()
	_play_color_intensity()

## Tweens shader param color1 over TWEEN_DURATION
func _play_color_one(from_color: Color, to_color: Color):
	var color_one_tween: Tween = create_tween()
	color_one_tween.tween_method(
		func(value: Color): material.set_shader_parameter("color1", value),
		from_color, to_color, TWEEN_DURATION)

## Tweens shader param color4 over TWEEN_DURATION
func _play_color_four(from_color: Color, to_color: Color):
	var color_four_tween: Tween = create_tween()
	color_four_tween.tween_method(
		func(value: Color): material.set_shader_parameter("color4", value),
		from_color, to_color, TWEEN_DURATION)

## Size pulse: 2.5 up to 3.5, then settle to 3.0 (TWEEN_DURATION total)
func _play_size():
	var size_tween: Tween = create_tween()
	size_tween.tween_method(
		func(value: float): material.set_shader_parameter("size", value),
		2.5, 3.5, TWEEN_DURATION * 0.5)
	size_tween.tween_method(
		func(value: float): material.set_shader_parameter("size", value),
		3.5, 3.0, TWEEN_DURATION * 0.5)

## Color intensity pulse: 0 up to 10, then back to 0 (TWEEN_DURATION total)
func _play_color_intensity():
	var color_intensity_tween: Tween = create_tween()
	color_intensity_tween.tween_method(
		func(value: float): material.set_shader_parameter("color_intensity", value),
		0.0, 10.0, TWEEN_DURATION * 0.5)
	color_intensity_tween.tween_method(
		func(value: float): material.set_shader_parameter("color_intensity", value),
		10.0, 0.0, TWEEN_DURATION * 0.5)
