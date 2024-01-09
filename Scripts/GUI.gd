extends Control

var level = Global.player_current_level
var exp = Global.player_current_exp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_gui()
	
func update_gui():
	var exp_bar = $exp_bar
	var needed = find_exp_needed(level)
	var current_level = str(level)
	exp_bar.value = exp
	exp_bar.max_value = needed
	$number.text = current_level
	

func find_exp_needed(level):
	var exp_needed = 2**level
	return snapped(exp_needed, 1.0)
