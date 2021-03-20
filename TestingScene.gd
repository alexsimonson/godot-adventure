extends Node2D
onready var test = get_node('/root/Brain')

func _ready():
	print('username: ' + test.username)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
