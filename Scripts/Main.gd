extends Node

onready var gui = get_node('GUI')

# Called when the node enters the scene tree for the first time.
func _ready():
	populate_main_menu()
	pass # Replace with function body.

func populate_main_menu():
	var main_menu_resource = load("res://Scenes/MainMenuUI.tscn")
	var main_menu = main_menu_resource.instance()
	gui.add_child(main_menu)
