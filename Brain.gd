extends Node2D

var username = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if(username==null):
		print('username not set')

func _set_username(name):
	print('setting username ' + name)
	username = name