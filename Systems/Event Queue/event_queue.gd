## Holds an array of [EventStage] objects which defines what tasks need to happen in which order [br]
## This system should be set up closely with a game scene manager/scene switcher, as when this queue is
## empty, the player should be switching to the next level
class_name EventQueue extends Node

@export var event_queue : Array[EventStage]

signal event_queue_finished


func _ready() -> void:
	start()


func start() -> void:
	if event_queue.is_empty():
		push_warning("%s: event_queue is empty and the queue didn't start, add events to make this system start!" % self)
		return
	advance_to_next_stage()


func connect_signals_from(stage : EventStage) -> void:
	if stage == null:
		printerr("%s: Cannot connect signals from null stage" % self)
		return
	
	stage.stage_finished.connect(_on_stage_finished)


func _on_stage_finished() -> void:
	advance_to_next_stage()


func advance_to_next_stage() -> void:
	# grab stages in-order
	var current_stage : EventStage = event_queue.pop_front()
	
	# check if no more stages exist
	if current_stage == null:
		event_queue_finished.emit()
		return
	
	# adv to next stage if we can
	connect_signals_from(current_stage)
	current_stage.start_stage()
