@abstract class_name AbstractInteractionHandler extends Node


const INTERACTABLE_GROUP_NAME : String = "Interactable"

## Returns the const value defining the group name for this class
##
## Intention is to grab group name from interaction handler so its ALWAYS checking against the right val
static func get_group_name() -> String:
	return INTERACTABLE_GROUP_NAME

## Add interactable node to proper group to ensure that its interactable
func _init(interactable_node : Node) -> void:
	interactable_node.add_to_group(AbstractInteractionHandler.get_group_name())


@abstract func call_interact(player : Player) -> void
