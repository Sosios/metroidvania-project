extends State
class_name PlayerJump

var player: CharacterBody2D

@export var speed = 10.0
@export var jump_velocity = 20.0

var speed_mult = 30.0
var jump_mult = -30.0


func enter():
	player = get_player()
	if player.is_in_gravity_area and player.is_gravity:
		player.velocity.y = -jump_velocity * jump_mult
	else:
		player.velocity.y = jump_velocity * jump_mult
	player.sprite.play("jump")

func physics_update(delta):
	#State transition
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
		player.velocity.x = direction * speed * speed_mult
		if player.velocity.x < 0:
			player.sprite.flip_h = true
			Globals.direction = -1
			player.attack_1_area.scale.x = -1
			player.attack_2_area.scale.x = -1
		else:
			player.sprite.flip_h = false
			Globals.direction = 1
			player.attack_1_area.scale.x = 1
			player.attack_2_area.scale.x = 1
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed * speed_mult)
	
	#Double jump
	if SaveLoad.save_file.can_double_jump:
		if Input.is_action_just_pressed("jump") and player.can_double_jump:
			if player.is_in_gravity_area:
				player.velocity.y = -jump_velocity * jump_mult
			else:
				player.velocity.y = jump_velocity * jump_mult
			player.can_double_jump = false
			
	#Transition to dash
	if Input.is_action_just_pressed("dash"):
		Transitioned.emit(self,"dash")
		player.sprite.play("fall")
