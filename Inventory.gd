extends 'res://Item.gd'

var inventory = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	print(inventory)
	pass # Replace with function body.

func _add_to_inventory(item):
	print('new item for inventory', item)
#	add_child(item)
#	inventory.append(item)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
