class_name EventStage extends Event

@export var events_in_stage : Array[Event]

var events_to_finish : Array[Event]

func enable() -> void:
	if events_in_stage.is_empty():
		push_error("%s: Stage has no tasks! Continuing to next stage" % self )
		finish()
		return
	
	connect_signals_to_all_tasks()
	events_to_finish = events_in_stage.duplicate(false)
	enable_all_tasks()


func disable() -> void:
	disconnect_signals_from_all_tasks()
	disable_all_tasks()


## Only enables tasks that are currently disabled
func enable_all_tasks() -> void:
	for event in events_in_stage:
		event.enable()


## Only disables tasks that are currently enabled
func disable_all_tasks() -> void:
	for event in events_in_stage:
		event.disable()


func connect_signals_to_all_tasks() -> void:
	for event in events_in_stage:
		if event.event_finished.is_connected(_on_event_finished):
			continue
		event.event_finished.connect(_on_event_finished)


func disconnect_signals_from_all_tasks() -> void:
	for event in events_in_stage:
		if !event.event_finished.is_connected(_on_event_finished):
			continue
		event.event_finished.disconnect(_on_event_finished)


func check_for_stage_finished() -> void:
	if !events_to_finish.is_empty():
		return
	disconnect_signals_from_all_tasks()
	finish()


func _on_event_finished(event : Event) -> void:
	events_to_finish.erase(event)
	event.disable()
	check_for_stage_finished()
