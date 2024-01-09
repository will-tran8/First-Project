extends Control


func _on_retry_pressed():
	Global.get_char_current(200, 100)
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/main.dialogue"), "Intro")

func _on_quit_pressed():
	get_tree().quit()
