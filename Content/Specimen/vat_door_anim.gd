extends Node3D
## Attach to VatDoorPlate. Call collapse() / expand() to play the animation.

signal collapsed
signal expanded

## Distance VatDoorPlate itself travels along global +Y after the stack has collapsed.
@export var door_lift: float = 1.0
## Seconds for each individual move (each plane, and the door).
@export var step_duration: float = 0.08
@export var trans_type: Tween.TransitionType = Tween.TRANS_SINE
@export var ease_type: Tween.EaseType = Tween.EASE_IN_OUT

var _chain: Array[Node3D] = []  # [VatDoorPlate, Plane_001, ..., Plane_026]
var _open_pos: PackedVector3Array = PackedVector3Array()  # local positions in the open state
var _tween: Tween


func _ready() -> void:
	var node: Node3D = self
	while node != null:
		_chain.append(node)
		_open_pos.append(node.position)
		node = _next_plane(node)


## Deepest plane moves first, each into its parent's global Y. The door lifts last.
func collapse() -> void:
	_begin()
	for i in range(_chain.size() - 1, 0, -1):
		var target_y: float = _chain[i - 1].global_position.y
		if not is_equal_approx(_chain[i].global_position.y, target_y):
			_tween.tween_property(_chain[i], "global_position:y", target_y, step_duration)
	var rest_y: float = (get_parent_node_3d().global_transform * _open_pos[0]).y
	_tween.tween_property(self, "global_position:y", rest_y + door_lift, step_duration)
	_tween.finished.connect(_on_collapse_finished)


## Reverse order: door returns first, then Plane_001 through Plane_026 return to their open positions.
func expand() -> void:
	visible = true
	_begin()
	var steps := 0
	for i in _chain.size():
		if not _chain[i].position.is_equal_approx(_open_pos[i]):
			_tween.tween_property(_chain[i], "position", _open_pos[i], step_duration)
			steps += 1
	if steps == 0:
		_tween.kill()
		expanded.emit()
		return
	_tween.finished.connect(expanded.emit)


func _on_collapse_finished() -> void:
	visible = false
	collapsed.emit()


func _begin() -> void:
	if _tween != null and _tween.is_valid():
		_tween.kill()
	_tween = create_tween().set_trans(trans_type).set_ease(ease_type)


func _next_plane(node: Node3D) -> Node3D:
	for child in node.get_children():
		if child is Node3D and String(child.name).begins_with("Plane_"):
			return child as Node3D
	return null
