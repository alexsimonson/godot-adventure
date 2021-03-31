# this script is currently the Player script...
# should separate things out accordingly
extends KinematicBody2D

export var speed = 200
export var sneakModifier = 2

var sneaking = false
var holding = false
var endangeringSelf = false

var velocity = Vector2.ZERO

onready var Inventory = get_parent().get_child(1)

# this bool should be enough, PROVIDED that all my interaction OBJECTS have a class with the same name which they should because OOP
var canInteract = false
var itemInteract = false
var npcInteract = false

var interactObj = null

func _ready():
	$Area2D.connect('body_entered', self, '_test_body')
	$Area2D.connect('area_entered', self, '_area_entered')
	$Area2D.connect('area_exited', self, '_area_exited')
	$Area2D.connect('mouse_entered', self, '_endanger_self')
	$Area2D.connect('mouse_exited', self, '_unendanger_self')
	print('player ready')

func _physics_process(delta):
	if(!holding):
		look_at(get_global_mouse_position())
	get_input()
	velocity = move_and_slide(velocity)

func _endanger_self():
	print('endangered self')
	endangeringSelf = true

func _unendanger_self():
	print('unendangered self')
	endangeringSelf = false

func _test_body(someArea):
	if(someArea.is_in_group('mobs')):
		print('stay away from mobs, dummy')

func _area_entered(someArea):
	# logic should be created to prioritize areas, etc.
	interactObj = someArea.get_parent()
	canInteract = true
	if(interactObj.is_in_group('item')):
		# canInteract will control the gui tooltip mostly
		print('Could pickup this item')
		itemInteract = true
	elif(interactObj.is_in_group('npc')):
		print('we should talk to this cunt')
		npcInteract = true

func _area_exited(someArea):
	# the logic here is causing bugs... figure out a better solution!
	# is it possible to rescan the areas?  PROBABLY
	canInteract = false
	interactObj = null
	itemInteract = false
	itemInteract = false
		
func _pickup_item(item):
	print('Attempting to pickup item here')
	Inventory._add_to_inventory(item)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed('click'):
		# I might need to use a specific boolean here instead.  Will find out in time.
		if(!Inventory.hudInventory.visible):
			shoot()
	if Input.is_action_just_pressed('right_click'):
		print('nothing yet on right click')

	if Input.is_action_pressed('sneak') && !sneaking:
		sneaking = true
		speed = speed / sneakModifier
	if Input.is_action_just_released('sneak') && !holding:
		speed = speed * sneakModifier
		sneaking = false
	if (Input.is_action_pressed('hold') && !holding) || (Input.is_action_just_released('hold')):
		holding = !holding
	if (Input.is_action_just_pressed('inventory')):
		print('toggle inventory on/off')
		Inventory.hudInventory.visible = !Inventory.hudInventory.visible
	if (Input.is_action_just_pressed('interact') && canInteract):
		print('calling fuckin')
		# item interaction passes self, we should branch because of that...
		if(itemInteract):
			interactObj._handle_interaction(self.get_parent())
		elif(npcInteract):
			interactObj._handle_interaction()

func shoot():
	$Gun.fire()
