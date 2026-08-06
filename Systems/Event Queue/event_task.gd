## An "Event" is defined as any gameplay or story beat that must happen in-order
## for the game to progress. An [EventTask] exists as a controller for that event to 
## get triggered by & notify the [EventStage] that the 
##
## The [EventTask] class is intended to be instanced under any scene which defines
## a clear event that must take place in order for the gameplay to progress
## This can either directly be an Interactable event, or some kind of one-off event that
## needs to happen between gameplay/story beats
##
## In either case, those "Events"
class_name EventTask extends Node

@warning_ignore("unused_signal")
signal task_finished

signal task_enable_state_updated(state : bool)

var enabled : bool = false


func finish() -> void:
	task_finished.emit()
	disable()


func enable() -> void:
	enabled = true
	task_enable_state_updated.emit(enabled)


func disable() -> void:
	enabled = false
	task_enable_state_updated.emit(enabled)
