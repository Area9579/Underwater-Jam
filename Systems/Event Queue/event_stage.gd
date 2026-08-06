class_name EventStage extends Node

signal stage_finished

@export var tasks : Array[EventTask]

var tasks_to_finish : Array[EventTask]


func start_stage() -> void:
	if tasks.is_empty():
		push_error("%s: Stage has no tasks! Continuing to next stage" % self )
		stage_finished.emit()
		return
	connect_signals_to_all_tasks()
	# take copy of tasks so that removing tasks from this list don't result in losing data
	tasks_to_finish = tasks.duplicate()
	for task in tasks_to_finish:
		task.start()


## Only enables tasks that are currently disabled
func enable_all_tasks() -> void:
	for task in tasks:
		if task.enabled:
			continue
		task.enable()


## Only disables tasks that are currently enabled
func disable_all_tasks() -> void:
	for task in tasks:
		if !task.enabled:
			continue
		task.disable()


func connect_signals_to_all_tasks() -> void:
	for task in tasks:
		task.task_finished.connect(_on_task_finished)


func disconnect_signals_from_all_tasks() -> void:
	for task in tasks:
		if !task.task_finished.is_connected(_on_task_finished):
			continue
		task.task_finished.connect(_on_task_finished)


func check_for_stage_finished() -> void:
	if !tasks_to_finish.is_empty():
		return
	disconnect_signals_from_all_tasks()
	stage_finished.emit()


func _on_task_finished(task : EventTask) -> void:
	tasks_to_finish.erase(task)
	check_for_stage_finished()
