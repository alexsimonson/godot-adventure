extends Control

var simultaneous_scene = preload('res://Scenes/Level1.tscn').instance()

func _ready():
	print_tree()
	$StartGameButton.connect("pressed", self, "_start_game_pressed")
	$LoginButton.connect('pressed', self, '_login_pressed')

	$StartGameButton.grab_focus()
	$StartGameButton.focus_mode = Control.FOCUS_ALL
	# It would be really nice to press enter to play game :)

func _start_game_pressed():
	# var basicLevelResource = load(basicLevel)
	# var test = basicLevelResource.instance()
	get_node('/root/Main/CurrentSceneContainer').add_child(simultaneous_scene)
	self.get_parent().remove_child(self)

func _login_pressed():
	# this appropriately swaps out the scene I need to swap
	var authScreenUIResource = load('res://Scenes/AuthScreenUI.tscn')
	var authScreenUI = authScreenUIResource.instance()
	self.get_parent().add_child(authScreenUI)
	self.get_parent().remove_child(self)
#	get_tree().change_scene('res://Scenes/AuthScreen.tscn')
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
