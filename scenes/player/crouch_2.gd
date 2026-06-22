extends State
class_name PlayerGetUp

var player: CharacterBody2D

var timer := 0.0833

func enter():
	player = get_player()
	player.sprite.play("get_up")
	
func physics_update(delta):
	timer -= delta
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self,"crouch_attack")
	if timer <= 0:
		player.animation_player.play_backwards("crouch")
		Transitioned.emit(self,"idle")
