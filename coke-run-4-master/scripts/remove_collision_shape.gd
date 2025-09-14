extends CollisionShape2D

@onready var animated_sprite = $"../../AnimatedSprite2D"

func _ready():
	if animated_sprite == null:
		print("Error: AnimatedSprite2D node not found!")
		return
	# Connect to animation_changed signal
	animated_sprite.animation_changed.connect(_on_animation_changed)

func _on_animation_changed():
	if animated_sprite.is_playing() and animated_sprite.animation == "fall":
		disabled = true
	else:
		disabled = false
		
