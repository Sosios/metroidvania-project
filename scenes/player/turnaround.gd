extends State
class_name PlayerTurnaround

var player: CharacterBody2D

@export var speed : float = 10.0

var speed_mult : float = 30.0

var timer: float

func enter():
	timer = 4*0.08333
	player = get_player()
	player.sprite.play("turnaround")
	var tween = create_tween()
	tween.tween_property(player,"velocity",Vector2.ZERO,0.2)
	

func physics_update(delta):
	
	timer -= delta
	if timer <= 0:
		Transitioned.emit(self,"idle")
	
	
