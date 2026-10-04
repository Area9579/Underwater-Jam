extends AudioStreamPlayer


@export var player : Player


var player_is_walking : bool = false


func _ready() -> void:
	self.finished.connect(_on_footstep_player_finished)
	if stream == null:
		push_warning("%s: Player footstep audio player has no stream set" % self)


func _physics_process(_delta: float) -> void:
	if player.velocity.round() == Vector3.ZERO or !player.is_on_floor() : return

	
	if !self.playing:
		self.play()


func _on_footstep_player_finished() -> void:
	if player.velocity.round() == Vector3.ZERO or !player.is_on_floor():
		self.stop()
		return
	
	self.play()
