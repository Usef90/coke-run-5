extends Control

@onready var inv: Inv = preload("res://inevntory/player_inventory.tres")
@onready var slots: Array = $GridContainer.get_children()



var is_open = false


func _ready() -> void:
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update_item(inv.items[i])



func close():
	visible = false
	is_open = false
func open():
	self.visible = true
	is_open = true

func _process(delta: float) -> void:
	if Global.has_coke:
		open()
