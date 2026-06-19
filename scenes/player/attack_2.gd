extends State
class_name PlayerAttack2

@onready var player: CharacterBody2D = get_player()

@onready var attack_time = 0.3

func enter():
	attack_time = 0.3
	player.velocity.x = 0.0
	player.sprite.play("attack_2")
	player.attack_2_area.monitoring = true
	
func update(delta):
	attack_time -= delta
	if attack_time <= 0:
		player.attack_2_area.monitoring = false
		Transitioned.emit(self,"idle")
		player.sprite.play("idle")
