extends Node2D
export var data = {
	"test": "hello",
	"another": "test"
}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _pickup_item(test):
	print('getting picked up', test.get_parent().data.test)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
