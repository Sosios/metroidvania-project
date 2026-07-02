extends State
class_name PlayerLand

var player: CharacterBody2D

@onready var timer

func enter():
	timer = 0.1
	player = get_player()
	player.velocity = Vector2(0,0)
	player.sprite.play("land")
	player.scale = Vector2(1.2,0.7)
	#var tween = create_tween()
	#tween.tween_property(player,"scale",Vector2(1,1),0.2)
	
func physics_update(delta):
	timer -= delta
	var direction = Input.get_axis("left","right")
	if timer <= 0:
		if !Globals.stop:
			if direction:
				Transitioned.emit(self,"run")
			else:
				Transitioned.emit(self,"idle")
