extends CanvasLayer

@onready var coke = $coke
@onready var frame1 = $frame1
@onready var coke_amount: Label = $coke_amount
@onready var frame2 = $frame2
@onready var pizza_slice = $PizzaSlice
@onready var pizza_amount: Label = $pizza_amount
func _ready():
	coke.hide()
	frame1.hide()
	pizza_slice.hide()
	frame2.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.has_coke == true:
		coke.show()
		frame1.show()
		coke_amount.text = str(int(Global.how_much_coke))
	
	else: 
		coke.hide()
	if Global.has_pizza_slice == true: 
		pizza_slice.show()
		frame2.show()
		pizza_amount.text = str(int(Global.how_much_pizza_slice))
	else:
		pizza_slice.hide()
