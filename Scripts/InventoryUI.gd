extends Panel
var isDragging = false
var draggingElement = null
var draggingTexture = null
var ogElement = null
var ogPosition = null
var ogContainer = null
var ogSet = false
export(int) var numSlots

var hoverRef = null

onready var yeGC = $ScrollContainer/GridContainer

const emptyIcon = preload('res://Icons/plain-square.png')
const gunIcon = preload('res://Icons/pistol-gun.png')

const gridSlot = preload('res://Scenes/GridSlot.tscn')

func _ready():
	# if this was the inventory script, we would attach InventoryUI to the GUI
	for n in numSlots:
		yeGC.add_child(gridSlot.instance())

func _process(delta):
	if(isDragging && draggingElement != null):
		draggingElement.set_position(get_global_mouse_position())


func _on_TextureRect_focus_entered():
	print('focus entered')

func _set_hover_vars(hoveredElement):
	hoverRef = hoveredElement