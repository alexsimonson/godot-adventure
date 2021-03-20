extends CenterContainer

onready var itemSlots = self.get_parent().get_parent().get_parent()
onready var dragMe = self.get_child(1)
export(bool) var thisSlot

const emptyIcon = preload('res://Icons/plain-square.png')
const gunIcon = preload('res://Icons/pistol-gun.png')

func _ready():
	self.set_size(Vector2(64, 64))
	set_texture()

func set_texture():
	if(thisSlot):
		dragMe.texture = gunIcon
	else:
		dragMe.texture = emptyIcon
