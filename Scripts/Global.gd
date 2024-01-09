extends Node


var player_current_attack = false

var current_scene = "world" #world hidden_1
var transition_scene = false

var player_starting_health = 200
var player_starting_speed = 100
var player_starting_level = 1
var player_starting_exp = 0
var player_starting_max_health = 200

var player_max_health = 200
var player_current_health = 200
var player_current_speed = 100
var player_current_level = 1
var player_current_exp = 0

var player_exit_main_posx = 199
var player_exit_main_posy = 29
var player_start_posx = 16
var player_start_posy = 59

var exp_to_be_updated = 0
var game_first_loadin = true

func finish_scenechange():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "hidden_1"
		else:
			current_scene = "world"

func get_char_current(x,y,z,a,b):
	player_max_health = x
	player_current_health = y
	player_current_speed = z
	player_current_level = a
	player_current_exp = b
	
func enemy_slain(enemy):
	if enemy == "slime":
		exp_to_be_updated = 1

func reset_exp():
	exp_to_be_updated = 0
