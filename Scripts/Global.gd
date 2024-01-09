extends Node


var player_current_attack = false

var current_scene = "world" #world hidden_1
var transition_scene = false

var player_starting_health = 200
var player_current_health = 10
var player_current_speed = 100
var player_exit_main_posx = 199
var player_exit_main_posy = 29
var player_start_posx = 16
var player_start_posy = 59

var game_first_loadin = true

func finish_scenechange():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "hidden_1"
		else:
			current_scene = "world"

func get_char_current(x,y):
	player_current_health = x
	player_current_speed = y
