extends Node

onready var gui = get_node('/root/Main/GUI')
export(int) var numSlots
const emptyIcon = preload('res://Icons/plain-square.png')

const gridSlot = preload('res://Scenes/GridSlot.tscn')

const InventoryUIScript = preload('res://Scripts/InventoryUI.gd')

const Item = preload('res://Scenes/Item.tscn')
var hudInventory = null

var gridGUI = null

var itemSlots = []

# to handle dropping an item to the ground, I need to be able to identify the current scene
onready var currentScene = get_node('/root/Main/CurrentSceneContainer').get_child(0)

func _ready():
	for n in numSlots:
		var itemSlot = {
			"slot": null,
		}
		itemSlots.append(itemSlot)
	create_inventory_ui()
	var inventoryUIResource = load('res://Scenes/InventoryUI.tscn')
	var inventoryUI = inventoryUIResource.instance()

func create_inventory_ui():
	# this will be responsible for creating the nodes from scratch
	var inventoryRoot = Panel.new()
	inventoryRoot.set_script(InventoryUIScript)
	inventoryRoot.set_name('Inventory')
	inventoryRoot.margin_right = 360
	inventoryRoot.margin_bottom = 350
	inventoryRoot.rect_size = Vector2(360, 350)
	inventoryRoot.add_child(ScrollContainer.new())
	var sc = inventoryRoot.get_child(0)
	sc.set_name('ScrollContainer')
	sc.margin_left = 6
	sc.margin_top = 17
	sc.margin_right = 294
	sc.margin_bottom = 278
	sc.rect_position = Vector2(6, 17)
	sc.rect_size = Vector2(288, 261)
	var grid = GridContainer.new()
	grid.set_name('GridContainer')
	grid.columns = 3
	sc.add_child(grid)
	for n in numSlots:
		var slot = gridSlot.instance()
		slot.fillSlot = false
		itemSlots[n].slot = slot
		grid.add_child(slot)
	gui.add_child(inventoryRoot)
	hudInventory = inventoryRoot
	hudInventory.visible = false
	gridGUI = grid

func _add_to_inventory(item):
	var added = false
	for n in numSlots:
		# if slot doesn't have item, add item to slot
		if(itemSlots[n].slot.fillSlot==false):
			itemSlots[n].slot.fillSlot = true
			itemSlots[n].slot.set_texture(item.randomItem.itemTexture)
			added = true
			break
	return added

func _drop_item(dropPosition):
	print('drop Posittion: ', dropPosition)
	print('drop item on ground if applicable')
	if(hudInventory.hoverRef):
		if(hudInventory.hoverRef.get_parent().fillSlot):
			print('we should drop this shit')
			hudInventory.hoverRef.get_parent().fillSlot = false
			hudInventory.hoverRef.texture = emptyIcon
			var droppedItem = load('res://Scenes/Item.tscn').instance()
			droppedItem.position = dropPosition
			currentScene.add_child(droppedItem)