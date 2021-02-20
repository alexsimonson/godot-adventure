extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	print_tree()
	$StartGameButton.connect("pressed", self, "_start_game_pressed")
	$LoginButton.connect('pressed', self, '_login_pressed')

func _start_game_pressed():
	get_tree().change_scene("res://TestingScene.tscn")

func _login_pressed():
	get_tree().change_scene('res://nodeTest.tscn')
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
