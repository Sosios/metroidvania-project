extends State
class_name PlayerJumpAttack1

@onready var player: CharacterBody2D = get_player()

@export var jump_velocity = 20.0

var speed_mult = 30.0
var jump_mult = -30.0

@export var attack_timer: Timer

@onready var attack_time = 0.3
var wait_time = 0.1

func enter():
	attack_time = 0.4162
	wait_time = 0.1
	player.velocity.x = 0.0
	player.sprite.play("jump_attack_1")
	player.animation_player.play("jump_attack1")
	
func update(delta):
	attack_time -= delta
	if attack_time <= 0:
		wait_time -= delta
		if wait_time > 0:
			if Input.is_action_just_pressed("attack"):
				Transitioned.emit(self,"jumpattack2")
		else:
			player.can_attack = false
			attack_timer.start()
			Transitioned.emit(self,"fall")
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.speed * speed_mult
		if player.velocity.x < 0:
			player.sprite.flip_h = true
			Globals.direction = -1
		else:
			player.sprite.flip_h = false
			Globals.direction = 1
		player.attack_1_area.position.x = abs(player.attack_1_area.position.x) * Globals.direction
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed * speed_mult)
	if player.velocity.y == 0:
		if direction:
			Transitioned.emit(self,"run")
		else:
			Transitioned.emit(self,"idle")
