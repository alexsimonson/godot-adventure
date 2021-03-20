extends Panel

const ItemSlotClass = preload('res://ItemSlot.gd')

const MAX_SLOTS = 10

var slotList = Array()

func _ready():
	var slots = get_node('ScrollContainer/GridContainer')
	for _i in range(MAX_SLOTS):
		print('making another slot')
		var slot = ItemSlotClass.new()
		slot.connect('mouse_entered', self, 'mouse_enter_slot', [slot])
		slot.connect('mouse_exited', self, 'mouse_exit_slot', [slot])
		slot.connect('gui_input', self, 'slot_gui_input', [slot])
		slotList.append(slot)
		slots.add_child(slot)

func mouse_enter_slot(_slot : ItemSlotClass):
	if _slot.item:
		print('a tool tip would normally display')
		# tooltip.display(_slot.item, get_global_mouse_position());

func mouse_exit_slot(_slot : ItemSlotClass):
	print('check to hide')
	# if tooltip.visible:
		# tooltip.hide();
