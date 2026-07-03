extends State
class_name PlayerAttack1

@onready var player: CharacterBody2D = get_player()

@export var attack_timer: Timer

@onready var attack_time = 0.3
var wait_time = 0.1

func enter():
	attack_time = player.attack_1_times[SaveLoad.save_file.player_selected]
	wait_time = 0.2
	player.velocity.x = 0.0
	player.sprite.play("attack_1")
	if Globals.direction == 1:
		player.animation_player.play("attack1_right")
	elif Globals.direction == -1:
		player.animation_player.play("attack1_left")
	
func update(delta):
	attack_time -= delta
	if attack_time <= 0:
		wait_time -= delta
		if wait_time > 0:
			if Input.is_action_just_pressed("attack"):
				Transitioned.emit(self,"attack2")
		else:
			player.attack_1_area.monitoring = false
			player.can_attack = false
			attack_timer.start()
			Transitioned.emit(self,"idle")
