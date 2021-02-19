extends KinematicBody2D

export var speed = 200

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
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed('click'):
		shoot()
	if Input.is_action_just_pressed('local_action'):
		local_action()
	if Input.is_action_just_pressed('right_click'):
		print('nothing yet')


func _physics_process(delta):
	look_at(get_global_mouse_position())
	get_input()
	velocity = move_and_slide(velocity)


func shoot():
	print('shooting')
	$Gun.fire()

func local_action():
	print('checking for local action')