extends State
class_name PlayerRun

var player: CharacterBody2D

@export var speed : float = 10.0

var speed_mult : float = 30.0



func enter():
	player = get_player()
	player.sprite.play("run")
	
func physics_update(_delta):
	
	#Movement
	var direction : float = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * speed * speed_mult
		if player.velocity.x < 0:
			player.sprite.flip_h = true
			Globals.direction = -1
			if SaveLoad.save_file.player_selected == 0:
				player.attack_1_area.position.x = -15
			for area in player.areas:
				area.scale.x = -1
		else:
			player.sprite.flip_h = false
			Globals.direction = 1
			if SaveLoad.save_file.player_selected == 0:
				player.attack_1_area.position.x = 6
			for area in player.areas:
				area.scale.x = 1
	
	#Transition to idle
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed * speed_mult)
		Transitioned.emit(self,"idle")
	
	#Transition to jump
	if Input.is_action_just_pressed("jump") and player.is_on_floor() and not Input.is_action_pressed("down"):
		Transitioned.emit(self,"jump")
		
	#Transition to attack
	if Input.is_action_just_pressed("attack") and player.can_attack:
		Transitioned.emit(self,"attack1")
		
	#Transition to dash
	if Input.is_action_just_pressed("dash"):
		Transitioned.emit(self,"dash")
		player.sprite.play("fall")
	
