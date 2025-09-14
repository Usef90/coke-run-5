extends CharacterBody2D

@export var speed = 100.0  # Movement speed in pixels per second
@export var min_walk_time = 2.0  # Minimum time to walk
@export var max_walk_time = 4.0  # Maximum time to walk
@export var min_idle_time = 0.5  # Minimum time to idle
@export var max_idle_time = 1.5  # Maximum time to idle
@onready var animated_sprite = $AnimatedSprite2D
var direction = 1.0  # 1 for right, -1 for left
var timer = 0.0
var state = "walk"  # Current state: "walk" or "idle"
var state_duration = 0.0  # Duration of the current state

func _ready():
	if not animated_sprite:
		push_error("AnimatedSprite2D node not found!")
	else:
		if animated_sprite.sprite_frames:
			if not animated_sprite.sprite_frames.has_animation("walk") or not animated_sprite.sprite_frames.has_animation("idle"):
				push_error("Required animations ('walk' or 'idle') not found in SpriteFrames!")
			else:
				animated_sprite.play("walk")  # Start with walk animation
				set_new_state("walk")  # Initialize state


func _physics_process(delta):
	# Update timer
	timer += delta
	if timer >= state_duration:
		# Decide next state (75% chance to walk, 25% chance to idle)
		if randf() < 0.75:
			set_new_state("walk")
		else:
			set_new_state("idle")
		timer = 0.0  # Reset timer

	# Handle movement and animation based on state
	if state == "walk":
		velocity.x = direction * speed
		velocity.y = 0
		if animated_sprite:
			animated_sprite.play("walk")
			animated_sprite.flip_h = direction < 0
	else:  # idle state
		velocity.x = 0
		velocity.y = 0
		if animated_sprite:
			animated_sprite.play("idle")

	# Move the CharacterBody2D
	move_and_slide()

func set_new_state(new_state: String):
	state = new_state  
	if state == "walk":
		state_duration = randf_range(min_walk_time, max_walk_time)  # Longer walk duration
		direction = 1.0 if randf() < 0.5 else -1.0  # Set direction once at the start of walk
	else:
		state_duration = randf_range(min_idle_time, max_idle_time)  # Shorter idle duration
