extends Sprite2D

var original_position: Vector2
var is_dragging: bool = false
var mouse_inside: bool = false

# Offsets
var drag_offset: Vector2 = Vector2(-1081, -30)
var home_offset: Vector2 = Vector2(0, 0)

# Example inventory count
func _ready() -> void:
	# Save original position with home offset applied
	original_position = position + home_offset
	position = original_position

func _process(delta: float) -> void:
	# Start drag
	if Input.is_action_just_pressed("left_click") and mouse_inside:
		if not is_dragging:
			is_dragging = true
			Global.took_coke = true
			# Decrease coke once when drag starts
			if Global.how_much_coke > 0:
				Global.how_much_coke  -= 1

	# End drag
	elif Input.is_action_just_released("left_click") and not Global.mouse_in_fridge_slot  and Global.took_coke:
		is_dragging = false
		position = original_position
		Global.how_much_coke += 1
		Global.took_coke = false
	# Update position while dragging
	if is_dragging and Global.took_coke:
		position = get_viewport().get_mouse_position() + drag_offset
	if Global.coke_in_fridge and Global.how_much_coke:
		hide()



func _on_area_2d_mouse_entered() -> void:
	mouse_inside = true
	Global.mouse_in_inventory_slot = true

func _on_area_2d_mouse_exited() -> void:
	mouse_inside = false
	Global.mouse_in_inventory_slot = false
