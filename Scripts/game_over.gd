extends Control


func _on_retry_pressed():
	Global.get_char_current(Global.player_starting_max_health, Global.player_starting_health, Global.player_starting_speed, Global.player_starting_level, Global.player_starting_exp)
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/main.dialogue"), "Intro")

func _on_quit_pressed():
	get_tree().quit()
