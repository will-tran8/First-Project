extends Control





func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/main.dialogue"), "Intro")
	


func _on_exit_pressed():
	get_tree().quit()
