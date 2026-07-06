extends CharacterBody2D
@export var sprite: AnimatedSprite2D

@export var attack_1_area: Area2D
@onready var areas = $Areas.get_children()

@onready var jump_sounds = $Sounds/JumpSounds.get_children()
@onready var land_sounds = $Sounds/LandSounds.get_children()
@onready var attack_1_sounds = $Sounds/Attack1Sounds.get_children()
@onready var attack_2_sounds = $Sounds/Attack2Sounds.get_children()
@onready var attack_3_sounds= $Sounds/Attack3Sounds.get_children()

@onready var run_sounds = $Sounds/RunSounds.get_children()
@onready var hit_sounds = $Sounds/HitSounds.get_children()
@onready var hit_voices = $Sounds/HitVoices.get_children()
@onready var jump_voices = $Sounds/JumpVoices.get_children()
@onready var dead_voices = $Sounds/DeadSounds.get_children()

var attack_1_times := [0.5,0.4162,0.4162]
var attack_2_times := [0.332,0.5,0.25]
var attack_3_times := [0.5,0.6664]

@onready var hit_timer: Timer = $Timers/HitTimer

@onready var general_ap: AnimationPlayer = $General

var hit_global_position: Vector2
var hit_damage: float

@export var invicibility = false

@onready var state_machine: Node = $StateMachine

@export var speed = 8.0
@export var jump_velocity = 10.0
@export var collision : CollisionShape2D
@export var animation_player: AnimationPlayer

var timer_lengths := [1.0,2.0,0.5]

var can_attack = true


		

@onready var animations = $AnimationPlayers.get_children()
@onready var sprites = $Sprites.get_children()
@onready var collisions = $Collisions.get_children()

var dead:= false

signal create_platform

var current_direction = 0

var speed_mult = 30.0
var jump_mult = -30.0
var can_double_jump = true
var can_move = true
var vuln = true

var air_time = 0.0

@onready var coyote_timer: Timer = $Timers/CoyoteTimer

@onready var jump_buffer_timer: Timer = $Timers/JumpBufferTimer
@onready var skill_timer: Timer = $Timers/SkillTimer



var is_gravity = false
var is_in_gravity_area:= false

var coyote := false
var buffer := false

var flip_h = false
var current_animation: String

func _ready() -> void:
	show()
	change_character()
	SaveLoad.save_file.connect("update",update_inventory)

func _physics_process(delta: float) -> void:
	if not skill_timer.is_stopped():
		Globals.elapsed_time = skill_timer.wait_time - skill_timer.time_left
		Globals.timer_length = skill_timer.wait_time
	
	if coyote and not is_on_floor():
		coyote_timer.start()
	coyote = is_on_floor()
	
	Globals.player_pos = global_position
	if !Globals.stop:
		if (velocity.y>0 and (not is_gravity or not is_in_gravity_area)) or (velocity.y<0 and is_gravity) and $StateMachine.current_state != $StateMachine/Fall:
			$StateMachine.current_state = $StateMachine/Fall
			$StateMachine/Fall.enter()
		
	
		if Input.is_action_pressed("down"):
			if Input.is_action_just_pressed("jump"):
				set_collision_mask_value(7, false)
				sprite.play("fall")
				$StateMachine.current_state = $StateMachine/Fall
				$StateMachine/Fall.enter()
				await get_tree().create_timer(0.2).timeout
				set_collision_mask_value(7, true)
				
		if $StateMachine.current_state.name != "Dash":
			if is_in_gravity_area and is_gravity and not is_on_ceiling():
				sprite.flip_v = true
				velocity -= get_gravity() * delta
				up_direction = Vector2.DOWN
			else:
				sprite.flip_v = false
				velocity += get_gravity() * delta
				up_direction = Vector2.UP
	
	move_and_slide()
	if attack_1_area.monitoring:
		for body in attack_1_area.get_overlapping_bodies():
			if "hit" in body:
				body.hit(SaveLoad.save_file.final_attack)
				

func change_character_right():
	if SaveLoad.save_file.player_selected < SaveLoad.save_file.characters_unlocked:
		SaveLoad.save_file.player_selected += 1
	else:
		SaveLoad.save_file.player_selected = 0
	change_character()

func change_character_left():
	if SaveLoad.save_file.player_selected == 0:
		SaveLoad.save_file.player_selected = SaveLoad.save_file.characters_unlocked
	else:
		SaveLoad.save_file.player_selected -= 1
	change_character()

func change_character():
	if not dead:
		attack_1_area.monitoring = false
		flip_h = sprite.flip_h
		current_animation = sprite.animation
		if SaveLoad.save_file.player_selected == 0:
			$Collision2.disabled = true
			$Collision3.disabled = true
			$Collision1.disabled = false
		elif SaveLoad.save_file.player_selected == 1:
			$Collision1.disabled = true
			$Collision3.disabled = true
			$Collision2.disabled = false
		else:
			$Collision1.disabled = true
			$Collision3.disabled = false
			$Collision2.disabled = true
		sprite = sprites[SaveLoad.save_file.player_selected]
		sprite.flip_h = flip_h
		sprite.play(current_animation)
		attack_1_area = sprite.get_child(0)
		#general_ap.play("change_chara")
		for animation in sprites:
			animation.hide()
		#await get_tree().create_timer(0.3).timeout
		sprite.show()
		#general_ap.play_backwards("change_chara")
		animation_player = animations[SaveLoad.save_file.player_selected]
		if SaveLoad.save_file.player_selected == 0:
			SaveLoad.save_file.final_attack = SaveLoad.save_file.attack
		elif SaveLoad.save_file.player_selected == 1:
			SaveLoad.save_file.final_attack = SaveLoad.save_file.attack * 0.9
		else:
			SaveLoad.save_file.final_attack = SaveLoad.save_file.attack * 1.2
			
		skill_timer.stop()
		skill_timer.wait_time = timer_lengths[SaveLoad.save_file.player_selected]
	


func update_inventory():
	pass

#func _on_attack_1_area_body_entered(body: Node2D) -> void:
	#if "hit" in body:
		#body.hit(Globals.damage)
#
#func _on_attack_2_area_body_entered(body: Node2D) -> void:
	#if "hit" in body:
		#body.hit(Globals.damage)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("create") and skill_timer.is_stopped() and SaveLoad.save_file.can_platform and SaveLoad.save_file.player_selected == 0 and $StateMachine.current_state not in [$StateMachine/Attack1,$StateMachine/Attack2,$StateMachine/Attack3,$StateMachine/Idle,$StateMachine/JumpAttack1,$StateMachine/JumpAttack2,$StateMachine/CrouchAttack]:
		create_platform.emit()
		skill_timer.start()
	
	if Input.is_action_just_pressed("gravity") and skill_timer.is_stopped() and SaveLoad.save_file.can_gravity and SaveLoad.save_file.player_selected == 2:
		is_gravity = !is_gravity
		skill_timer.start()
		
	if $StateMachine.current_state not in [$StateMachine/Attack1,$StateMachine/Attack2,$StateMachine/Attack3,$StateMachine/CrouchAttack,$StateMachine/JumpAttack1,$StateMachine/JumpAttack2]:
		if Input.is_action_just_pressed("lb"):
			change_character_left()
		if Input.is_action_just_pressed("rb"):
			change_character_right()

func shade(color):
	$WallParticles.emitting = true
	var tween = create_tween()
	tween.tween_method(set_progress_value,0.0,0.8,0.2)
	$ShadeLight.enabled = true
	#sprite.material.set_shader_parameter("progress", 0.8);	

func unshade():
	$WallParticles2.emitting = (true)
	var tween = create_tween()
	tween.tween_method(set_progress_value,0.8,0.0,0.2)
	#sprite.material.set_shader_parameter("progress", 0.0);
	$ShadeLight.enabled = false

func hurt(damage,pos):
	if vuln and not invicibility and not dead:
		hit_global_position = pos
		hit_damage = damage
		vuln = false
		hit_timer.start()
		$StateMachine.current_state = $StateMachine/Hit
		$StateMachine/Hit.enter()
		if Globals.health <= 0.0:
			$StateMachine.current_state = $StateMachine/Dead
			$StateMachine/Dead.enter()
			dead = true

func _on_hit_timer_timeout() -> void:
	vuln = true

func set_progress_value(value: float):
	# in my case i'm tweening a shader on a texture rect, but you can use anything with a material on it
	sprite.material.set_shader_parameter("progress", value);


func _on_attack_timer_timeout() -> void:
	can_attack = true
