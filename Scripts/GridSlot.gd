extends CenterContainer

onready var dragMe = self.get_child(0)
export(bool) var fillSlot # set to true to populate with an item

const emptyIcon = preload('res://Icons/plain-square.png')
const gunIcon = preload('res://Icons/pistol-gun.png')

func _ready():
	self.set_size(Vector2(64, 64))
	set_texture()

func set_texture(itemTexture=null, setByObject=false):
	if(fillSlot):
		if(setByObject):
			dragMe.texture = itemTexture
		else:
			dragMe.texture = load(itemTexture)
	else:
		dragMe.texture = emptyIcon
