extends State
class_name PlayerJump

var player: CharacterBody2D

@export var jump_velocity = 20.0

var speed_mult = 30.0
var jump_mult = -30.0


func enter():
	player = get_player()
	player.animation_player.play("RESET")
	player.scale = Vector2(0.8,1.2)
	if player.is_in_gravity_area and player.is_gravity:
		player.velocity.y = -jump_velocity * jump_mult * 0.9
	else:
		player.velocity.y = jump_velocity * jump_mult * 0.9
	player.sprite.play("jump")
	var tween = create_tween()
	tween.tween_property(player,"scale",Vector2(1,1),0.4)

func physics_update(delta):
	#State transition
	if Input.is_action_just_released("jump") and player.velocity.y < 0.0:
		player.velocity.y *= 0.45
	if player.velocity.y > 0:
		player.sprite.play("fall")
	if player.is_on_floor() or (player.is_gravity and player.is_on_ceiling()):
		Transitioned.emit(self,"idle")
		player.sprite.play("idle")
		player.can_double_jump = true
	
	if player.is_gravity and player.is_in_gravity_area:
		player.velocity -= player.get_gravity() * delta
	
	#Jump movement
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = move_toward(player.velocity.x, direction * player.speed * speed_mult,2500 * delta)
		if player.velocity.x < 0:
			player.sprite.flip_h = true
			Globals.direction = -1
		else:
			player.sprite.flip_h = false
			Globals.direction = 1
		#player.attack_1_area.position.x = abs(player.attack_1_area.position.x) * Globals.direction
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, 2500 * delta)
	
	#Double jump
	if SaveLoad.save_file.can_double_jump:
		if Input.is_action_just_pressed("jump") and player.can_double_jump:
			if player.is_in_gravity_area:
				player.velocity.y = -jump_velocity * jump_mult
			else:
				player.velocity.y = jump_velocity * jump_mult
			player.can_double_jump = false
			
	#Transition to dash
		
	if !Globals.stop:
		if Input.is_action_just_pressed("attack") and player.can_attack and SaveLoad.save_file.player_selected == 0:
			Transitioned.emit(self,"jumpattack1")
		#Transition to dash
		if Input.is_action_just_pressed("dash")  and player.skill_timer.is_stopped() and SaveLoad.save_file.can_dash and SaveLoad.save_file.player_selected == 1:
			Transitioned.emit(self,"dash")
			player.sprite.play("fall")
			player.skill_timer.start()
