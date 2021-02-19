extends KinematicBody2D

export var speed = 200
export var sneakModifier = 2

var sneaking = false
var holding = false

var velocity = Vector2.ZERO

func _ready():
	print('player ready')

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
		shoot()
	if Input.is_action_just_pressed('local_action'):
		local_action()
	if Input.is_action_just_pressed('right_click'):
		print('nothing yet')

	if Input.is_action_pressed('sneak') && !sneaking:
		sneaking = true
		speed = speed / sneakModifier
	if Input.is_action_just_released('sneak') && !holding:
		speed = speed * sneakModifier
		sneaking = false
	if (Input.is_action_pressed('hold') && !holding) || (Input.is_action_just_released('hold')):
		holding = !holding


func _physics_process(delta):
	if(!holding):
		look_at(get_global_mouse_position())
	get_input()
	velocity = move_and_slide(velocity)

func shoot():
	print('shooting')
	$Gun.fire()

func local_action():
	print('checking for local action')

func _on_KinematicBody2D_mouse_entered():
	print('ay')
	pass # Replace with function body.
