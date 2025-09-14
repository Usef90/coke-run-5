extends Area2D

@export var sprite: Node2D 
@onready var open_fridge = $open_fridge
@onready var event_camera = $open_fridge/EventCamera
@onready var player_camera = get_node("/root/Main/Delivery boy/PlayerCamera")



func _ready():
	sprite.hide()
	open_fridge.visible = false  # make sure it's hidden by default
	var player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("e_pressed"):  # assuming "E" is mapped to ui_accept
		open_fridge.visible = true
		switch_to_event_camera()




func _on_area_entered(area):
	sprite.show()
	if area.name == "Delivery boy":
		player_in_area = true
 



func _on_area_exited(area):
	sprite.hide()
	if area.name == "Delivery boy":
		player_in_area = false
		# optional: hide fridge if leaving area
		open_fridge.visible = false
		switch_to_player_camera()

func switch_to_event_camera():
	event_camera.current = true
	player_camera.current = false

func switch_to_player_camera():
	event_camera.current = false
	player_camera.current = true
