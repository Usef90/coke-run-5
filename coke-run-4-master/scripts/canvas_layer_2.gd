extends CanvasLayer

@onready var timer_label: Label = $TimerLabel




func _process(delta: float) -> void:
	if not Global.timer_started:
		timer_label.visible = false
	# Check if we're in the "outside" scene and the timer hasn't started yet
	if not Global.timer_started and get_tree().current_scene.name == "outside":
		Global.timer_started = true
		timer_label.visible = true  # Show the timer

	# If the timer has started, count down
	if Global.timer_started and Global.time_left > 0:
		Global.time_left -= delta
		if Global.time_left < 0:
			Global.time_left = 0
	
	# Update the label if it's visible
	if timer_label.visible:
		timer_label.text = str(int(Global.time_left))
