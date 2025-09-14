extends CanvasLayer

@onready var task_label: Label = $TaskLabel

func _process(delta: float) -> void:
	# Update the label text
	task_label.text = Global.current_task

	# Move the label when timer starts
	if Global.timer_started:
		task_label.position = Vector2(0, 30)
