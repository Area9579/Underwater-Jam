class_name PlayerStateMachine extends StateMachine

@export var player : Player


func _ready() -> void:
	if player == null:
		printerr("%s: No player object is set in export" % self.name)
		return
	
	setup_states()


func setup_states() -> void:
	for state in states:
		(state as PlayerState).player = self.player
		state.state_machine = self
	
	curr_state = get_first_state_of_type(IdlePlayerState)
