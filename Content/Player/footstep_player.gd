extends AudioStreamPlayer


@export var state_machine : EntityStateMachine

var player_is_walking : bool = false


func _ready() -> void:
	self.finished.connect(_on_footstep_player_finished)
	if stream == null:
		push_warning("%s: Player footstep audio player has no stream set" % self)


func _physics_process(_delta: float) -> void:
	if state_machine.curr_state is WalkingEntityState:
		player_is_walking = true
	else:
		player_is_walking = false

	if !player_is_walking:
		return
	
	if !self.playing:
		self.play()


func _on_footstep_player_finished() -> void:
	if !player_is_walking:
		self.stop()
		return
	
	self.play()
