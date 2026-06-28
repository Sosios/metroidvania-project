extends State
class_name PlayerGetUp

var player: CharacterBody2D

var timer := 0.0833

func enter():
	timer = 0.166
	player = get_player()
	player.velocity = Vector2.ZERO
	player.sprite.play("get_up")
	player.animation_player.play_backwards("crouch")
	
func physics_update(delta):
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self,"jump")
	timer -= delta
	if timer <= 0:
		player.animation_player.play_backwards("crouch")
		Transitioned.emit(self,"idle")
