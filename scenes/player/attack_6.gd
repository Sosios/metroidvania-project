extends State
class_name PlayerAttack6

@onready var player: CharacterBody2D = get_player()

@export var attack_timer: Timer

@onready var attack_time = 0.3
var wait_time = 0.1

func enter():
	attack_time = 16.0*0.0833
	wait_time = 0.2
	player.velocity.x = 0.0
	player.sprite.play("attack_6")
	player.animation_player.play("attack6")
	
func update(delta):
	attack_time -= delta
	if attack_time <= 0:
		player.can_attack = false
		attack_timer.start()
		Transitioned.emit(self,"idle")
