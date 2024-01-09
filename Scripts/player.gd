extends CharacterBody2D

var enemy_in_range = false
var enemy_attack_cooldown = true
var health = 200
var player_alive = true

var attack_ip = false

const speed = 100
var current_dir = "down"

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	current_camera()
	update_health()
	
	if health <= 0:
		player_alive = false
		health = 0
		print("game over")
		self.queue_free()

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
	
	if health >= 200:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regen_timer_timeout():
	if health < 200:
		health = health + 2
		if health > 200:
			health = 200
	if health <= 0:
		health = 0
