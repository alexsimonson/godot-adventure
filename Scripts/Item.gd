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

# pickup item
func _handle_interaction(interacted):
	interacted.get_child(1)._add_to_inventory(self)
	self.queue_free()