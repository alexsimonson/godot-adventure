extends TextureRect

onready var Inventory = get_node('/root/Main/GUI/Inventory')
onready var container = self.get_parent()

func _on_DragMe_mouse_entered():
	if(!container.fillSlot):
		Inventory.setOGPosition(self)

func _on_DragMe_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if(Inventory.isDragging):
				# need to determine if slot is full or not.
				if(container.fillSlot):
					print('we should exchange items')
					var curSlotTexture = container.dragMe.texture
					var dragSlotTexture = Inventory.draggingTexture
					container.set_texture(dragSlotTexture, true)
					Inventory.draggingElement.texture = curSlotTexture
					Inventory.draggingTexture = curSlotTexture
				else:
					print('we should drop this item in this slot')
					Inventory.isDragging = false
					Inventory.resetPosition()
					container.fillSlot = true
					container.set_texture(Inventory.draggingTexture, true)
			else:				
				if(Inventory.ogSet):
					if(container.fillSlot):
						print('there is something in this slot')
						Inventory.draggingElement = Sprite.new()
						Inventory.draggingTexture = container.dragMe.texture
						Inventory.draggingElement.texture = Inventory.draggingTexture
						Inventory.add_child(Inventory.draggingElement)
						Inventory.ogElement.texture = Inventory.emptyIcon
						container.fillSlot = false
						container.set_texture()
						Inventory.isDragging = true
					else:
						print('nothing in this slot!')
		elif event.button_index == BUTTON_RIGHT && !event.pressed:
			print('right click pressed')