extends Node2D

@onready var result_label: Label = $ResultLabel

func _ready():
	if Global.has_coke and Global.time_left > 0:
		result_label.text = "Win"
	else:
		result_label.text = "Lose"
