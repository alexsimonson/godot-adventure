extends CenterContainer

onready var dragMe = self.get_child(0)
export(bool) var fillSlot # set to true to populate with an item

const emptyIcon = preload('res://Icons/plain-square.png')

func _ready():
	self.set_size(Vector2(64, 64))
	set_texture()

func set_texture(itemTexture=null):
	if(fillSlot):
		dragMe.texture = load(itemTexture)
	else:
		dragMe.texture = emptyIcon
