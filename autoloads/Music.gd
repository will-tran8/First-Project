extends Node


# Called when the node enters the scene tree for the first time.
func play_music():
	$AudioStreamPlayer.playing = true

func stop_music():
	$AudioStreamPlayer.playing = false
