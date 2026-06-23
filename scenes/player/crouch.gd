extends State
class_name PlayerCrouch

var player: CharacterBody2D


func enter():
	player = get_player()
	
func physics_update(delta):
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self,"crouchattack")
	if !Input.is_action_pressed("down"):
		Transitioned.emit(self,"getup")
