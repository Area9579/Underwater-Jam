class_name PhScaleLever extends ValveControl


var interaction_handler : PhScaleLeverInteractionHandler = PhScaleLeverInteractionHandler.new(self)

@warning_ignore("unused_signal")
signal value_changed(value : float)
