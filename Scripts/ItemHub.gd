extends Node2D

var item_data
var numItems

var dialogueData
# basic interfacing with a file to read and utilize JSON
func _ready():
	_setup_items_by_file('res://sampleItems.json', 'item') # this is for items
	_setup_items_by_file('res://dialogue.json', 'dialogue') # this is for items

func _setup_items_by_file(filePath, type):
	var fileData = File.new()
	fileData.open(filePath, File.READ)
	var data_json = JSON.parse(fileData.get_as_text())
	fileData.close()
	if(type=='item'):
		item_data = data_json.result
		numItems = item_data.size()
	elif(type=='dialogue'):
		dialogueData = data_json.result

func _random_item():
	# get random number between 0 and size
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var randomNumber = rng.randi_range(0, numItems)
	# return a random item from the item_data set
	var count = 0
	for item in item_data:
		if(count==randomNumber):
			# use this item
			return item_data[item]
		count = count + 1