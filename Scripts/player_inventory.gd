extends Node

const Num_Inventory_Slots = 20

var inventory = {
	0: ["Iron Sword", 1]
}

var equips = {
	0: ["Brown Shirt", 1],
	1: ["Iron Sword", 1],
}

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			inventory[item][1] += item_quantity
			return;
	
	for i in range(Num_Inventory_Slots):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return
	
