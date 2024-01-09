extends CharacterBody2D

var enemy_name = String("slime")

var speed = 50
var player_chase = false
var player = null

var health = 100
var player_in_range = false
var can_take_damage = true
var death_animation = false

func _physics_process(delta):
	take_damage()
	update_health()
	
	if health <= 0:
		if death_animation == false:
			$AnimatedSprite2D.play("death")
		else:
			Global.enemy_slain(enemy_name)
			self.queue_free()
		
	elif player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
	else:
		$AnimatedSprite2D.play("idle")
		
	move_and_slide()


func _on_area_2d_body_entered(body):
	player = body
	player_chase = true
	


func _on_area_2d_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass


func _on_area_2d_2_body_entered(body):
	if body.has_method("player"):
		player_in_range = true


func _on_area_2d_2_body_exited(body):
	if body.has_method("player"):
		player_in_range = false
		
func take_damage():
	if player_in_range and Global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$cooldown.start()
			can_take_damage = false
			print("slime health = ", health)
			if health <= 0:
				$death_animation.start()
				
				


func _on_cooldown_timeout():
	can_take_damage = true

func update_health():
	var healthbar = $health_bar
	 
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


func _on_death_animation_timeout():
	death_animation = true
