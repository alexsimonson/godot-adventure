extends Node

onready var gui = get_node('/root/Main/GUI')
export(int) var numSlots
const emptyIcon = preload('res://Icons/plain-square.png')
const gunIcon = preload('res://Icons/pistol-gun.png')

const gridSlot = preload('res://Scenes/GridSlot.tscn')

const InventoryUIScript = preload('res://Scripts/InventoryUI.gd')
var hudInventory = null

var gridGUI = null

# let's try tracking some data here
var itemSlots = [] # this will be a fairly large data array



func _ready():
	for n in numSlots:
		var itemSlot = {
			"item": null,
			"slot": null,
		}
		itemSlots.append(itemSlot)
	create_inventory_ui()
	# this will need to instantiate an InventoryUI onto the GUI
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
	print('inventory gui created', itemSlots)

func _add_to_inventory(item):
	# this works but it just appends a new slot to the inventory
	# should actually cycle through all of the nodes to find empty slot
	# this is quickly becoming difficult to expand on...
	# it would be easier to track the data independently from the gui
	# the obviously build the gui from the tracked data
	# Where should I track the data?
	print('Identify item: ', item.name)
	print('Identify data: ', item.data)
	var added = false
	for n in numSlots:
		# if slot doesn't have item, add item to slot
		if(itemSlots[n].item==false):
			print('we found an empty slot')
			# I may have overcomplicated this but it's working right now
			itemSlots[n].item = true
			itemSlots[n].slot.fillSlot = true
			itemSlots[n].slot.set_texture()
			added = true
			break
	if(!added):
		print('Your inventory must be full')