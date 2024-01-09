extends Node


var player_current_attack = false

var current_scene = "world" #world hidden_1
var transition_scene = false

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
