extends Node2D

var username = 'hello'
var loggedIn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print_tree()
	if(username==null):
		print('username not set')

func _set_username(name):
	print('setting username ' + name)
	username = name
