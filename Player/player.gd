class_name Player extends CharacterBody3D

@export var speed : float = 5.0
@export var mouse_sensitivity : float = 0.003
## Value used in delta-adjusted calculations
@export var acceleration: float = 10.0
@export var look_enabled : bool = true
@export var movement_enabled : bool = true

## Rotation helper to make head rotation not break :)
@onready var head: Node3D = %Head
## The player state machine contains all logic for player movement & look logic
@onready var player_state_machine: PlayerStateMachine = %PlayerStateMachine


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


## Head rotation for first-person controls
func _input(event: InputEvent) -> void:
	# show cursor in first person mode
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# capture cursor on mouse click
	if event is InputEventMouseButton and event.pressed:
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if !look_enabled:
		return
	
	# rotate head
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
