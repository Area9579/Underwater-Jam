## Holds an array of [EventStage] objects which defines what tasks need to happen in which order [br]
## This system should be set up closely with a game scene manager/scene switcher, as when this queue is
## empty, the player should be switching to the next level
class_name EventQueue extends Node

@export var event_queue : Array[Event]

signal event_queue_finished


func _ready() -> void:
	start()


func start() -> void:
	if event_queue.is_empty():
		push_warning("%s: event_queue is empty and the queue didn't start, add events to make this system start!" % self)
		return
	
	# ensure all events are disabled as starting default
	for event in event_queue:
		if event == null:
			printerr("%s: Null event!" % self)
			continue
		
		if !event.is_node_ready():
			push_warning("%s: EventQueue has to wait for event: %s to be ready" % [self, event])
			await event.ready
		
		event.disable()
	
	advance_to_next_stage()


func connect_signals_from(event : Event) -> void:
	if event == null:
		printerr("%s: Cannot connect signals from null event" % self)
		return
	
	if !event.event_finished.is_connected(_on_event_finished):
		event.event_finished.connect(_on_event_finished)


func disconnect_signals_from(event : Event) -> void:
	if event == null:
		printerr("%s: Cannot connect signals from null event" % self)
		return
	
	if event.event_finished.is_connected(_on_event_finished):
		event.event_finished.disconnect(_on_event_finished)


func _on_event_finished(event : Event) -> void:
	if event != null:
		disconnect_signals_from(event)
		event.disable()
	advance_to_next_stage()


func advance_to_next_stage() -> void:
	# grab stages in-order
	var current_stage : Event = event_queue.pop_front()
	
	# check if no more stages exist
	if current_stage == null:
		event_queue_finished.emit()
		print_rich("[rainbow freq=1.0 sat=0.8 val=0.8 speed=1.0][wave amp=20.0 freq=2.0 connected=1]YOU FINISHED ALL YOUR TASKS :)")
		return
	
	# adv to next stage if we can
	connect_signals_from(current_stage)
	current_stage.enable()
