extends Node

onready var gui = get_node('/root/Main/GUI')
export(int) var numSlots
const emptyIconLocation = 'res://Icons/plain-square.png'

const gridSlot = preload('res://Scenes/GridSlot.tscn')

const InventoryUIScript = preload('res://Scripts/InventoryUI.gd')
var hudInventory = null

var gridGUI = null

var itemSlots = []

func _ready():
	for n in numSlots:
		var itemSlot = {
			"item": null,
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
		itemSlots[n].item = false
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
		if(itemSlots[n].item==false):
			itemSlots[n].item = true
			itemSlots[n].slot.fillSlot = true
			itemSlots[n].slot.set_texture(item.randomItem.itemTexture)
			added = true
			break
	return added