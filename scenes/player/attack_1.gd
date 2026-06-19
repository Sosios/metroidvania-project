extends State
class_name PlayerAttack1

@onready var player: CharacterBody2D = get_player()

@onready var attack_time = 0.3
var wait_time = 0.1

func enter():
	attack_time = 0.3
	wait_time = 0.2
	player.velocity.x = 0.0
	player.sprite.play("attack_1")
	player.attack_1_area.monitoring = true
	
func update(delta):
	attack_time -= delta
	if attack_time <= 0:
		player.attack_1_area.monitoring = false
		wait_time -= delta
		if wait_time > 0:
			if Input.is_action_just_pressed("attack"):
				Transitioned.emit(self,"attack2")
		else:
			player.sprite.play("idle")
			Transitioned.emit(self,"idle")
