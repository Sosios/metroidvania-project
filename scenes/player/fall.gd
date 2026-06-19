extends State
class_name PlayerFall

@onready var player: CharacterBody2D = get_player()

@export var speed = 10.0
@export var jump_velocity = 10.0

var speed_mult = 30.0
var jump_mult = -30.0

func _enter() -> void:
	player.sprite("fall")

func physics_update(delta):
	#Air movement
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * speed * speed_mult
		if player.velocity.x < 0:
			player.sprite.flip_h = true
			Globals.direction = -1
			player.attack_1_area.scale.x = -1
			player.attack_2_area.scale.x = -1
		else:
			player.sprite.flip_h = false
			Globals.direction = 1
			player.attack_1_area.scale.x = 1
			player.attack_2_area.scale.x = 1
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed * speed_mult)
	
	#Idle transition
	if player.velocity.y == 0:
		Transitioned.emit(self,"idle")
		player.sprite.play("idle")
		player.can_double_jump = true
	
	#Double jump
	if SaveLoad.save_file.can_double_jump:
		if Input.is_action_just_pressed("jump") and player.can_double_jump:
			Transitioned.emit(self,"jump")
			player.can_double_jump = false
	
	#Transition to dash
	if Input.is_action_just_pressed("dash"):
		Transitioned.emit(self,"dash")
		player.sprite.play("fall")
