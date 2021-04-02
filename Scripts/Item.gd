extends Node2D
export var data = {
	"test": "hello",
	"another": "test"
}

# how do I access itemHub here?
onready var itemHub = get_node('/root/ItemHub')
onready var currentScene = get_node('/root/Main/CurrentSceneContainer').get_child(0)

onready var spr = self.get_child(0)
var randomItem = null

# Called when the node enters the scene tree for the first time.
func _ready():
	randomItem = itemHub._random_item()
	spr.texture = load(randomItem.itemTexture)
	pass # Replace with function body.

# pickup item
func _handle_interaction(interacted):
	var interactionHandled = interacted.get_child(1)._add_to_inventory(self)
	if(interactionHandled):
		self.queue_free()