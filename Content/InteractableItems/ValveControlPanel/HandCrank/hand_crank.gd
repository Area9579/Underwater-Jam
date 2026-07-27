class_name HandCrank extends Area3D

var interaction_handler : HandCrankInteractionHandler = HandCrankInteractionHandler.new(self)

@warning_ignore("unused_signal")
signal increment_value
@warning_ignore("unused_signal")
signal decrement_value
