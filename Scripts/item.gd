extends Node2D

var item_name
var item_quantity

func _ready():
	var rand_val = randi() % 2
	if rand_val == 0:
		item_name = "Iron Sword"
	elif rand_val == 1:
		item_name = "Tree Branch"

	$TextureRect.texture = load("res://Images/" + item_name + ".png")
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	item_quantity = randi() % stack_size + 1
	 
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = str(item_quantity)

func set_item(name, quantity):
	item_name = name
	item_quantity = quantity
	$TextureRect.texture = load("res://Images/" + item_name +".png")
	
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = str(item_quantity)

func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = str(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = str(item_quantity)
