extends State
class_name PlayerCrouch

var player: CharacterBody2D


func enter():
	player = get_player()
	player.sprite.play("crouch")
	
func physics_update(delta):
	if Input.is_action_just_released("down"):
		Transitioned.emit(self,"getup")
