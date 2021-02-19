extends Node2D

onready var Bullet = preload("res://Bullet.tscn")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	look_at(get_global_mouse_position())

func fire():
#	print('firing the gun')
	var b = Bullet.instance()
	var world = get_tree().current_scene
	world.add_child(b)
	b.transform = $Muzzle.global_transform
	$Gunshot.play()
