extends Node2D

@onready var player_camera = $"Delivery boy"/PlayerCamera
@onready var event_camera = $Area2D/open_fridge/EventCamera
@onready var trigger_sprite = $Area2D/open_fridge


func _process(_delta: float) -> void:
	# Make sure the trigger_sprite exists
	if trigger_sprite:
		if trigger_sprite.visible:
			switch_to_event_camera()
		else:
			switch_to_player_camera()

# Functions to switch cameras
func switch_to_event_camera() -> void:
	if player_camera:
		player_camera.current = false
	if event_camera:
		event_camera.current = true

func switch_to_player_camera() -> void:
	if event_camera:
		event_camera.current = false
	if player_camera:
		player_camera.current = true
