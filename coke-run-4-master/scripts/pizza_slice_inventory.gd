extends Sprite2D

var original_position: Vector2
var is_dragging: bool = false
var mouse_inside: bool = false
var took_pizza_slice = false
# Offsets
var drag_offset: Vector2 = Vector2(-990, 65)
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
			Global.took_pizza_slice = true
			# Decrease coke once when drag starts
			if Global.how_much_pizza_slice > 0:
				Global.how_much_pizza_slice  -= 1

	# End drag
	elif Input.is_action_just_released("left_click") and Global.took_pizza_slice and not Global.mouse_in_fridge_slot:
		is_dragging = false
		position = original_position
		Global.how_much_pizza_slice += 1
		Global.took_pizza_slice = false
	# Update position while dragging
	if is_dragging and Global.took_pizza_slice:
		position = get_viewport().get_mouse_position() + drag_offset
	if Global.pizza_slice_in_fridge:
		hide()
	
	if Input.is_action_just_released("left_click") and Global.took_pizza_slice and Global.mouse_in_fridge_slot and not Global.can_go_in_fridge_slot_1:
		is_dragging = false
		position = original_position
		Global.how_much_pizza_slice += 1
		Global.took_pizza_slice = false

func _on_area_2d_mouse_entered():
	mouse_inside = true

func _on_area_2d_mouse_exited():
	mouse_inside = false
