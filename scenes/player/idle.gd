extends State
class_name PlayerIdle

var player: CharacterBody2D

func enter():
	player = get_player()
	player.sprite.play("idle")
	player.velocity.x = 0.0

func physics_update(delta):
	
	if Input.is_action_just_pressed("jump") and not Input.is_action_pressed("down"):
		Transitioned.emit(self,"jump")
	var direction := Input.get_axis("left", "right")
	if !Globals.stop:
		if direction:
			Transitioned.emit(self,"run")
		if Input.is_action_just_pressed("attack") and player.can_attack:
			Transitioned.emit(self,"attack1")
		#Transition to dash
		if Input.is_action_just_pressed("dash") and SaveLoad.save_file.can_dash and SaveLoad.save_file.player_selected == 1:
			Transitioned.emit(self,"dash")
			player.sprite.play("fall")
		if Input.is_action_just_pressed("down") and SaveLoad.save_file.player_selected == 0:
			player.sprite.play("crouch")
			player.animation_player.play("crouch")
			Transitioned.emit(self,"crouch")
	
