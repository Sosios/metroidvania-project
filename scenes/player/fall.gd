extends State
class_name PlayerFall

@onready var player: CharacterBody2D = get_player()

@export var jump_velocity = 10.0

var coyote_timer: float

var air_time = 0.0

var speed_mult = 30.0
var jump_mult = -30.0

func _enter() -> void:
	coyote_timer = 2.0
	player.sprite("fall")
	var tween = create_tween()
	tween.tween_property(player,"scale",Vector2(0.7,1.3),0.2)

func physics_update(delta):
	player.velocity.y *= 1.1
	#Air movement
	if Input.is_action_just_pressed("jump"):
		player.jump_buffer_timer.start()
	air_time += delta
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.speed * speed_mult
		if player.velocity.x < 0:
			player.sprite.flip_h = true
			Globals.direction = -1
			player.attack_1_area.scale.x = -1
		else:
			player.sprite.flip_h = false
			Globals.direction = 1
			player.attack_1_area.scale.x = 1
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed * speed_mult)
	
	#Idle transition
	if player.velocity.y == 0:
		player.scale = Vector2(1.2,0.8)
		if direction:
			Transitioned.emit(self,"run")
		else:
			if Input.is_action_pressed("down"):
				player.sprite.play("crouch")
				player.animation_player.play("crouch")
				Transitioned.emit(self,"crouch")
			else:
				Transitioned.emit(self,"idle")

	
	#Double jump
	if SaveLoad.save_file.can_double_jump:
		if Input.is_action_just_pressed("jump") and player.can_double_jump:
			Transitioned.emit(self,"jump")
			player.can_double_jump = false
	
	#Transition to dash
	if !Globals.stop:
		if Input.is_action_just_pressed("attack") and player.can_attack and SaveLoad.save_file.player_selected == 0:
			Transitioned.emit(self,"jumpattack1")
		#Transition to dash
		if Input.is_action_just_pressed("dash") and SaveLoad.save_file.can_dash and SaveLoad.save_file.player_selected == 1:
			Transitioned.emit(self,"dash")
			player.sprite.play("fall")
