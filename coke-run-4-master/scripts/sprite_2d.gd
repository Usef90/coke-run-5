extends Sprite2D
@export var target_scene: String = "res://inside.tscn"
@onready var result_label: Label = $ResultLabel

func _ready():
	if Global.has_coke and Global.time_left > 0:
		result_label.text = "Win"
	elif Global.has_coke and Global.time_left == 0:
		result_label.text = "Lose"
	else:
		result_label.text = "Go get my coke"


func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file(target_scene)
