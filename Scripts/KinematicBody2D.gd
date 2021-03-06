# this script is currently the Player script...
# should separate things out accordingly
extends KinematicBody2D

export var speed = 200
export var sneakModifier = 2

var removeControl = false
var sneaking = false
var holding = false
var endangeringSelf = false

var velocity = Vector2.ZERO

onready var Inventory = get_parent().get_child(1)

# this bool should be enough, PROVIDED that all my interaction OBJECTS have a class with the same name which they should because OOP
var proximityInteract = false
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
	if(!holding && !removeControl):
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
	proximityInteract = true
	if(interactObj.is_in_group('item')):
		itemInteract = true
	elif(interactObj.is_in_group('npc')):
		npcInteract = true

func _area_exited(someArea):
	# the logic here is causing bugs... figure out a better solution!
	# is it possible to rescan the areas?  PROBABLY
	proximityInteract = false
	interactObj = null
	itemInteract = false
	itemInteract = false

func cancel_movement():
	velocity = Vector2(0, 0)

func calculate_movement():
	# calculate movement
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

func primary_action():
	# handle primary action
	if Input.is_action_just_pressed('click'):
		# I might need to use a specific boolean here instead.  Will find out in time.
		if(!Inventory.hudInventory.visible):
			shoot()

func get_input():
	# lock certain things behind control
	if(!removeControl):
		calculate_movement()
		primary_action()
	else:
		cancel_movement()
	if Input.is_action_just_pressed('right_click'):
		# maybe this should spawn a dropdown UI at mouse_location on GUI

		Inventory._drop_item(self.position)

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
	if (Input.is_action_just_pressed('interact') && proximityInteract):
		# item interaction passes self, we should branch because of that...
		
		# we need to figure out how to determine precedence over interacted items
		if(itemInteract):
			if(interactObj.is_in_group('item')):
				interactObj._handle_interaction(self.get_parent())
			else:
				print('preventing error')
		elif(npcInteract):
			print('should be interacting with npc?')
			# we should get something back from this interaction that tells us we're engaged in conversation
			# this should be a bool
			look_at(interactObj.position)
			removeControl = interactObj._handle_interaction(self)

func shoot():
	$Gun.fire()
