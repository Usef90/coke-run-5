

extends Area2D

@export var sprite: Node2D
@onready var collision = $CollisionShape2D
var player_in_area = false
var action_in_progress = false

func _ready():
	player_in_area = false

func _process(delta):
	# Reset action when button released
	if not Input.is_action_pressed("e_pressed"):
		action_in_progress = false

	# Perform purchase once per key press
	if player_in_area and Global.cash >= 5 and Input.is_action_just_pressed("e_pressed") and not action_in_progress:
		action_in_progress = true
		buy_pizza_slice()

func buy_pizza_slice():
	Global.cash -= 5
	sprite.hide()
	collision.disabled = true
	Global.has_pizza_slice = true
	Global.how_much_pizza_slice += 1








func _on_area_entered(area):
	player_in_area = true


func _on_area_exited(area):
	player_in_area = false
