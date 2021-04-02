extends TextureRect

onready var Inventory = get_node('/root/Main/GUI/Inventory')
onready var container = self.get_parent()

func _on_DragMe_mouse_entered():
	Inventory._set_hover_vars(self)

	# if(!container.fillSlot && Inventory.isDragging):
	# 	print('testing when this happens')
	# 	Inventory.setOGPosition(self)

func _on_DragMe_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if(Inventory.isDragging):
				# need to determine if slot is full or not.
				if(container.fillSlot):
					_exchange_item_logic()
				else:
					_place_item_logic()
			else:				
				if(container.fillSlot):
					_pickup_item_logic()
				else:
					print('nothing in this slot!')
		elif event.button_index == BUTTON_RIGHT && !event.pressed:
			print('right click pressed')


func _pickup_item_logic():
	print('there is something in this slot')
	print('testing: ', Inventory.hoverIcon)
	Inventory.draggingElement = Sprite.new()
	Inventory.draggingElement.texture = Inventory.hoverIcon
	Inventory.add_child(Inventory.draggingElement)
	Inventory.hoverRef.texture = Inventory.emptyIcon
	Inventory.hoverRef.get_parent().fillSlot = false
	# container.fillSlot = false
	# container.set_texture()
	Inventory.isDragging = true

func  _place_item_logic():
	print('we should drop this item in this slot')
	Inventory.hoverRef.texture = Inventory.draggingElement.texture
	Inventory.remove_child(Inventory.draggingElement)
	Inventory.isDragging = false
	Inventory.hoverRef.get_parent().fillSlot = true
	# Inventory.resetPosition()
	# container.fillSlot = true
	# container.set_texture(Inventory.draggingTexture, true)

func _exchange_item_logic():
	print('we should exchange items')
	var curSlotTexture = Inventory.hoverRef.texture
	var dragSlotTexture = Inventory.draggingElement.texture
	Inventory.hoverRef.texture = dragSlotTexture
	Inventory.draggingElement.texture = curSlotTexture
