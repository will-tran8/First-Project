extends Node2D

var item_name
var item_quantity

func _ready():
	var rand_val = randi() % 2
	if rand_val == 0:
		item_name = "Iron Sword"
	elif rand_val == 1:
		item_name = "Tree Branch"
