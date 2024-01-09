extends Node2D

func _ready():
	if Global.game_first_loadin == true:
		Music.play_music()
		$player.position.x = Global.player_start_posx
		$player.position.y = Global.player_start_posy
	else:
		$player.position.x = Global.player_exit_main_posx
		$player.position.y = Global.player_exit_main_posy

func _process(delta):
	change_scene()

func _on_transition_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://Scenes/hidden_1.tscn")
			Global.game_first_loadin = false
			Global.finish_scenechange()
