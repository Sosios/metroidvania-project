extends State
class_name PlayerLand

var player: CharacterBody2D

@onready var timer

func enter():
	timer = 0.1
	player = get_player()
	player.velocity = Vector2(0,0)
	player.sprite.play("land")
	
func physics_update(delta):
	timer -= delta
	var direction = Input.get_axis("left","right")
	if timer <= 0:
		if !Globals.stop:
			if direction:
				Transitioned.emit(self,"run")
			else:
				Transitioned.emit(self,"idle")
