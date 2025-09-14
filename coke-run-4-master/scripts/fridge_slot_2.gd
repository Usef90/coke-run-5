extends Area2D
@onready var sprite = $Sprite2D
@onready var coke = $coke
@onready var pizza_slice = $pizza_slice
var mouse_in_area = false
var is_dragging = false
var fridge_slot_fill = false




func _on_mouse_entered():
	sprite.modulate = Color(0.5, 0.5, 0.5)
	mouse_in_area = true
	print("yes")
	Global.mouse_in_fridge_slot = true
 
func _on_mouse_exited():
	sprite.modulate = Color(1, 1, 1)
	mouse_in_area = false
	Global.mouse_in_fridge_slot = false

func _ready() -> void:
	coke.hide()
	pizza_slice.hide()

func _process(delta: float) -> void:
	if Global.took_coke and mouse_in_area and Input.is_action_just_released("left_click") and not fridge_slot_fill:
		coke.show()
		Global.took_coke = false
		Global.coke_in_fridge = true
		fridge_slot_fill = true
		Global.can_go_in_fridge_slot = false
	
	elif Global.took_pizza_slice and mouse_in_area and Input.is_action_just_released("left_click") and not fridge_slot_fill:
		pizza_slice.show()
		Global.took_pizza_slice = false
		Global.pizza_slice_in_fridge = true
		fridge_slot_fill = true
		
		Global.can_go_in_fridge_slot = false

	
	
	
	
	if Global.pizza_slice_in_fridge and mouse_in_area and Input.is_action_just_pressed("left_click"):
		Global.pizza_slice_in_fridge = false
		
		pizza_slice.hide()
		Global.took_pizza_slice = true
		fridge_slot_fill = false
		Global.can_go_in_fridge_slot = true
	
	if Global.coke_in_fridge and mouse_in_area and Input.is_action_just_pressed("left_click"):
		Global.coke_in_fridge = false
	
		coke.hide()
		Global.took_coke = true
		fridge_slot_fill = false
		Global.can_go_in_fridge_slot = true
	
		
