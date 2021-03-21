extends Control

func _ready():
	print_tree()
	$StartGameButton.connect("pressed", self, "_start_game_pressed")
	$LoginButton.connect('pressed', self, '_login_pressed')

func _start_game_pressed():
	var next_level_resource = load('res://Scenes/TestingScene.tscn')
	var next_level = next_level_resource.instance()
	get_node('/root/Main/CurrentSceneContainer').add_child(next_level)
	self.get_parent().remove_child(self)

func _login_pressed():
	# this appropriately swaps out the scene I need to swap
	var next_level_resource = load("res://Scenes/AuthScreenUI.tscn")
	var next_level = next_level_resource.instance()
	self.get_parent().add_child(next_level)
	self.get_parent().remove_child(self)
#	get_tree().change_scene('res://Scenes/AuthScreen.tscn')
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
