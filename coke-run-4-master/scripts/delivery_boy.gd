extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 900.0
@onready var collision_shape = $CollisionShape2D

var is_playing_forced_anim: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Predefine collision shape sizes (extents = half of size)
const IDLE_EXTENTS = Vector2(52.5, 137.5)  # 105x275
const WALK_EXTENTS = Vector2(40, 137.5)    # 80x275

# Predefine sprite offsets
const OFFSET_RIGHT = Vector2(0, 0)
const OFFSET_LEFT = Vector2(-9, 0)

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0 if velocity.y > 0 else velocity.y

	# Handle forced animations (jump/push)
	if is_playing_forced_anim:
		if animated_sprite.animation == "push":
			velocity.x = 0
		move_and_slide()
		return

	# Movement input
	var direction := 0
	if Input.is_action_pressed("a_pressed"):
		direction = -1
	elif Input.is_action_pressed("d_pressed"):
		direction = 1

	velocity.x = direction * speed

	# Flip sprite + adjust offset
	if direction != 0:
		if direction < 0:
			animated_sprite.flip_h = true
			animated_sprite.offset = OFFSET_LEFT
		else:
			animated_sprite.flip_h = false
			animated_sprite.offset = OFFSET_RIGHT
	else:
		# Idle: keep facing last direction
		if animated_sprite.flip_h:
			animated_sprite.offset = OFFSET_LEFT
		else:
			animated_sprite.offset = OFFSET_RIGHT

	# Animation + collision shape logic
	if Input.is_action_just_pressed("spacebar_pressed") and is_on_floor():
		velocity.y = jump_velocity
		_play_forced_animation("jump")
	elif Input.is_action_just_pressed("f_pressed"):
		_play_forced_animation("push")
	elif direction != 0:
		animated_sprite.play("walk")
		(collision_shape.shape as RectangleShape2D).extents = WALK_EXTENTS   # walking size
	else:
		animated_sprite.play("idle")
		(collision_shape.shape as RectangleShape2D).extents = IDLE_EXTENTS    # idle size

	move_and_slide()

func _play_forced_animation(anim_name: String) -> void:
	is_playing_forced_anim = true
	animated_sprite.play(anim_name)
	if not animated_sprite.is_connected("animation_finished", Callable(self, "_on_anim_finished")):
		animated_sprite.animation_finished.connect(_on_anim_finished)

func _on_anim_finished() -> void:
	if animated_sprite.animation == "jump" or animated_sprite.animation == "push":
		is_playing_forced_anim = false
