extends Area2D

# Path to the target scene
@export var target_scene: String = "res://outside.tscn"
var player_in_area = false




func _process(delta):
	if player_in_area and Input.is_action_just_pressed("e_pressed"):
		get_tree().change_scene_to_file(target_scene)




func _on_area_entered(area):
	player_in_area = true


func _on_area_exited(area):
	player_in_area = false
