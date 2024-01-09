extends CharacterBody2D

var enemy_in_range = false
var enemy_attack_cooldown = true
var object_in_range = false
var player_alive = true
var interaction_running = false
var death_animation = false
var attack_ip = false

var max_health = Global.player_max_health
var health = Global.player_current_health
var speed = Global.player_current_speed
var level = Global.player_current_level
var experience = Global.player_current_exp

var current_dir = "down"

@onready var all_interactions = []
@onready var interactlabel = $interactive_componenets/interactlabel



func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	Global.get_char_current(max_health, health, speed, level, experience)
	player_movement(delta)
	enemy_attack()
	attack()
	current_camera()
	update_health()
	execute_interaction()
	check_exp()
	update_exp()
	update_gui()
	
	if health <= 0:
		if death_animation == false:
			$AnimatedSprite2D.play("death")
			Music.stop_music()
		else:
			player_alive = true
			Transit.get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
		
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
		
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
		
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
		
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_anim(direction):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if direction == 1 :
			anim.play("side_walk")
		elif direction == 0:
			if attack_ip == false:
				anim.play("side_idle")
	
	if dir == "left":
		anim.flip_h = true
		if direction == 1 :
			anim.play("side_walk")
		elif direction == 0:
			if attack_ip == false:
				anim.play("side_idle")
			
	if dir == "down":
		anim.flip_h = false
		if direction == 1 :
			anim.play("front_walk")
		elif direction == 0:
			if attack_ip == false:
				anim.play("front_idle")
			
	if dir == "up":
		anim.flip_h = false
		if direction == 1 :
			anim.play("back_walk")
		elif direction == 0:
			if attack_ip == false:
				anim.play("back_idle")

func player():
	pass

func _on_area_2d_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_range = true

func _on_area_2d_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_range = false

func enemy_attack():
	if enemy_in_range == true and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$cooldown.start()
		print(health)

func _on_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$attack_timer.start()
			$AudioStreamPlayer.play()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$attack_timer.start()
			$AudioStreamPlayer.play()
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$attack_timer.start()
			$AudioStreamPlayer.play()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$attack_timer.start()
			$AudioStreamPlayer.play()

func _on_attack_timer_timeout():
	$attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false

func current_camera():
	if Global.current_scene == "world":
		$world_camera.enabled = true
		$hidden1_camera.enabled = false
	elif Global.current_scene == "hidden_1":
		$world_camera.enabled = false
		$hidden1_camera.enabled = true

func update_health():
	var healthbar = $health_bar
	healthbar.value = health
	healthbar.max_value = max_health
	
	if health >= max_health:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regen_timer_timeout():
	if player_alive == true:
		if health < max_health:
			health = health + 2
			if health > max_health:
				health = max_health
		if health <= 0:
			health = 0
			player_alive = false
			$death_animation.start()
		

func _on_interactable_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()

func _on_interactable_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interactlabel.text = all_interactions[0].interact_label
	else:
		interactlabel.text = ""

func execute_interaction():
	if Input.is_action_pressed("interact"):
		if all_interactions and interaction_running == false:
			var current_interaction = all_interactions[0]
			match current_interaction.interact_type:
				"print_dialogue": 
					DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/main.dialogue"), current_interaction.interact_value)
			interaction_running = true

func _on_death_animation_timeout():
	death_animation = true

func find_exp_needed(level):
	var exp_needed = 2**level
	return snapped(exp_needed, 1.0)

func check_exp():
	var needed = find_exp_needed(level)
	if needed <= experience:
		level += 1
		max_health += 20
		experience = 0

func update_exp():
	experience += Global.exp_to_be_updated
	Global.reset_exp()

func update_gui():
	var exp_bar = $CanvasLayer/exp_bar
	var needed = find_exp_needed(level)
	var current_level = str(level)
	exp_bar.value = experience
	exp_bar.max_value = needed
	$CanvasLayer/number.text = current_level


