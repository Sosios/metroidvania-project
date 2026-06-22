extends State
class_name PlayerAttack5

@onready var player: CharacterBody2D = get_player()

@export var attack_timer: Timer

@onready var attack_time = 0.3
var wait_time = 0.1

func enter():
	attack_time = 13.0*0.0833
	wait_time = 0.2
	player.velocity.x = 0.0
	player.sprite.play("attack_5")
	player.animation_player.play("attack5")
	
func update(delta):
	attack_time -= delta
	if attack_time <= 0:
		wait_time -= delta
		if wait_time > 0:
			if Input.is_action_just_pressed("attack") and SaveLoad.save_file.player_selected == 1:
				Transitioned.emit(self,"attack6")
		else:
			player.can_attack = false
			attack_timer.start()
			Transitioned.emit(self,"idle")
