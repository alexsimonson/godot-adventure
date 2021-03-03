extends Node2D

var username = 'hello'
var loggedIn = false
onready var ItemHub = get_node('/root/ItemHub')

# Called when the node enters the scene tree for the first time.
func _ready():
	print('item hub chooses coin', ItemHub.item_data['Coin'])
	if(username==null):
		print('username not set')

func _set_username(name):
	print('setting username ' + name)
	username = name
