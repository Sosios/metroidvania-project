extends State
class_name PlayerDash

var player: CharacterBody2D

@export var dash_speed = 25.0

var dash_time

var speed_mult = 30.0


func enter():
	dash_time = 0.2
	player = get_player()
	player.velocity.y = 0
	player.sprite.play("fall")
	player.set_collision_mask_value(9,false)
	
func physics_update(delta):
	dash_time -= delta
	player.velocity.x = dash_speed * speed_mult * Globals.direction
	if dash_time <= 0:
		player.velocity.x = 0
		player.set_collision_mask_value(9,true)
		if not player.is_on_floor():
			Transitioned.emit(self,"fall")
		else:
			Transitioned.emit(self,"idle")
			player.sprite.play("idle")
