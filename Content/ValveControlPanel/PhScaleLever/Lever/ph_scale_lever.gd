class_name PhScaleLever extends ValveControl

const MIN_ROTATION : float = 0.0
const MAX_ROTATION : float = 45.0
const ROT_OFFSET : float = 0.0

# we store these values on scale of 0.0 to 1.0, then translate them to rot
var curr_value : float
var target_value : float

var interaction_handler : PhScaleLeverInteractionHandler = PhScaleLeverInteractionHandler.new(self)


func get_rotation_from_curr_value() -> float:
	return Utils.remap_with_clamp(curr_value, 0.0, 1.0, MIN_ROTATION + ROT_OFFSET, MAX_ROTATION + ROT_OFFSET)
