extends CanvasLayer
@onready var cash: Label = $cash

# Called when the node enters the scene tree for the first time.
func _ready():
	cash.text = str(int(Global.cash))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cash.text = str(int(Global.cash))
