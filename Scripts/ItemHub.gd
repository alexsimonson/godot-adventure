extends Node2D

var item_data
var numItems
# basic interfacing with a file to read and utilize JSON
func _ready():
	_setup_items_by_file()
	print('numItems: ', numItems)

func _setup_items_by_file():
	var item_data_file = File.new()
	item_data_file.open('res://sampleItems.json', File.READ)
	var item_data_json = JSON.parse(item_data_file.get_as_text())
	item_data_file.close()
	item_data = item_data_json.result
	numItems = item_data.size()
	# for key in item_data:
		# print('key: ', key, ' - value: ', item_data[key])
		# print('Weight of ', key, ' - ', item_data[key].ItemWeight)

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