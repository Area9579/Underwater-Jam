class_name Player extends CharacterBody3D

@export var speed : float = 5.0
@export var mouse_sensitivity : float = 0.003
## Value used in delta-adjusted calculations
@export var acceleration: float = 10.0

@onready var head: Node3D = %Head

## The player state machine contains all logic for player movement & look logic
@onready var player_state_machine: PlayerStateMachine = %PlayerStateMachine

const SPEED = 5.0
const MOUSE_SENSITIVITY : float = 0.003

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
