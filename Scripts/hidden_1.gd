extends Node2D

func _process(delta):
	change_scenes()

func _on_hidden_transition_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true

func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "hidden_1":
			get_tree().change_scene_to_file("res://Scenes/world.tscn")
			Global.finish_scenechange()
