extends Panel
@onready var Item_visual: Sprite2D = $CenterContainer/Panel/item_display

func update_item(item: InvItem):
	if not item:
		Item_visual.visible = false
	else: 
		Item_visual.visible = true
		Item_visual.texture = item.texture
	
