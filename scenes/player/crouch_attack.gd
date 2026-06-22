extends State
class_name PlayerCrouchAttack

@onready var player: CharacterBody2D = get_player()

@export var attack_timer: Timer

@onready var attack_time : float
var wait_time = 0.1

func enter():
	attack_time = 0.75
	wait_time = 0.1
	player.sprite.play("crouch_attack")
	player.animation_player.play("crouch_attack")
	
func update(delta):
	if attack_time > 0:
		attack_time -= delta
	else:
		player.can_attack = false
		attack_timer.start()
		Transitioned.emit(self,"crouch")
