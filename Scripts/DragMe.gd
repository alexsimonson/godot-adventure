extends TextureRect

onready var itemSlots = get_node('/root/Main/GUI/Inventory')
onready var container = self.get_parent()

func _ready():
	print('name of', itemSlots.name)

func _on_DragMe_mouse_entered():
	if(!container.fillSlot):
		itemSlots.setOGPosition(self)

func _on_DragMe_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if(itemSlots.isDragging):
				itemSlots.isDragging = false
				itemSlots.resetPosition()
				container.fillSlot = true
				container.set_texture()
			else:				
				if(itemSlots.ogSet):
					if(container.fillSlot):
						print('there is something in this slot')
						itemSlots.draggingElement = Sprite.new()
						itemSlots.draggingElement.texture = itemSlots.gunIcon
						itemSlots.add_child(itemSlots.draggingElement)
						itemSlots.ogElement.texture = itemSlots.emptyIcon
						container.fillSlot = false
						container.set_texture()
						itemSlots.isDragging = true
					else:
						print('nothing in this slot!')
		elif event.button_index == BUTTON_RIGHT && !event.pressed:
			print('right click pressed')
