extends Area2D

@export var player_in_area = false
@export var move_speed = 100.0  # Speed of movement in pixels per second
@onready var animated_sprite = $AnimatedSprite2D
@onready var Collision_shape = $CollisionShape2D

var is_moving = false
var move_direction = 1  # 1 for right, -1 for left
var time_until_action = 0.0
var is_falling = false

func _ready():
	player_in_area = false
	choose_random_action()

func _process(delta):
	if is_falling:
		return  # Stop all other behaviors if falling

	if player_in_area and Input.is_action_just_pressed("f_pressed"):
		animated_sprite.play("fall")
		is_falling = true
		animated_sprite.connect("animation_finished", _on_fall_animation_finished, CONNECT_ONE_SHOT)
		return

	# Handle random movement and idle
	time_until_action -= delta
	if time_until_action <= 0:
		choose_random_action()

	if is_moving:
		animated_sprite.play("walk")
		position.x += move_direction * move_speed * delta

		# Flip sprite and adjust offset
		if move_direction < 0:
			animated_sprite.flip_h = true
			animated_sprite.offset.x = -9
		else:
			animated_sprite.flip_h = false
			animated_sprite.offset.x = 0
	else:
		animated_sprite.play("idle")
		animated_sprite.offset.x = 0  # ✅ reset offset when idle

func choose_random_action():
	# Randomly decide to move or idle
	is_moving = randi() % 2 == 0
	if is_moving:
		# Randomly choose direction
		move_direction = 1 if randi() % 2 == 0 else -1
	# Set random duration for this action (between 1 and 3 seconds)
	time_until_action = randf_range(1.0, 3.0)

func _on_fall_animation_finished():
	if animated_sprite.animation == "fall":
		set_process(false)  # Stop all processing

func _on_area_entered(area):
	player_in_area = true


func _on_area_exited(area):
	player_in_area = false
