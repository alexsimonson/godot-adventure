extends Node2D

var item_data

# basic interfacing with a file to read and utilize JSON
func _ready():
	var item_data_file = File.new()
	item_data_file.open('res://items.json', File.READ)
	var item_data_json = JSON.parse(item_data_file.get_as_text())
	item_data_file.close()
	item_data = item_data_json.result
	print('item_data', item_data)
	for key in item_data:
		print('key: ', key, ' - value: ', item_data[key])
		print('Weight of ', key, ' - ', item_data[key].ItemWeight)