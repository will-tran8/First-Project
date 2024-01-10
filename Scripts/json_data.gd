extends Node

var item_data: Dictionary

func _ready():
	item_data = LoadData("res://Data/ItemData.json")
	

func LoadData(file):
	var file_data = FileAccess.get_file_as_string(file)
	var json_data = JSON.parse_string(file_data)
	return json_data

