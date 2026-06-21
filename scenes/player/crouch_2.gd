extends State
class_name PlayerGetUp

var player: CharacterBody2D

var timer := 0.0833

func enter():
	player = get_player()
	player.sprite.play("get_up")
	
func physics_update(delta):
	timer -= delta
	if timer <= 0:
		Transitioned.emit(self,"idle")
