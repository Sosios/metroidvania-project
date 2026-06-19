extends State
class_name PlayerIdle

var player: CharacterBody2D

func enter():
	player = get_player()
	player.velocity.x = 0.0

func physics_update(delta):
	
	if Input.is_action_just_pressed("jump") and not Input.is_action_pressed("down"):
		Transitioned.emit(self,"jump")
	var direction := Input.get_axis("left", "right")
	if !Globals.stop:
		if direction:
			Transitioned.emit(self,"run")
		if Input.is_action_just_pressed("attack"):
			Transitioned.emit(self,"attack1")
		#Transition to dash
		if Input.is_action_just_pressed("dash"):
			Transitioned.emit(self,"dash")
			player.sprite.play("fall")
	
