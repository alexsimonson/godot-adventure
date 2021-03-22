extends Node

onready var gui = get_node('/root/Main/GUI')
export(int) var numSlots
const emptyIcon = preload('res://Icons/plain-square.png')
const gunIcon = preload('res://Icons/pistol-gun.png')

const gridSlot = preload('res://Scenes/GridSlot.tscn')

const InventoryUIScript = preload('res://Scripts/InventoryUI.gd')

func _ready():
	create_inventory_ui()
	# this will need to instantiate an InventoryUI onto the GUI
	var inventoryUIResource = load('res://Scenes/InventoryUI.tscn')
	var inventoryUI = inventoryUIResource.instance()
#	gui.add_child(inventoryUI)

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
		if(n==1):
			slot.fillSlot = true
		grid.add_child(slot)
	gui.add_child(inventoryRoot)
	print('did it')