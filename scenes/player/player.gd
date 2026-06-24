extends CharacterBody2D
@export var sprite: AnimatedSprite2D

@export var attack_1_area: Area2D
@onready var areas = $Areas.get_children()

var attack_1_times := [0.5,0.4162,0.4162]
var attack_2_times := [0.332,0.5,0.25]
var attack_3_times := [0.5,0.6664]

@onready var hit_timer: Timer = $Timers/HitTimer

@export var invicibility = false

@onready var state_machine: Node = $StateMachine

@export var speed = 10.0
@export var jump_velocity = 10.0
@export var collision : CollisionShape2D
@export var animation_player: AnimationPlayer

var can_attack = true


		

@onready var animations = $AnimationPlayers.get_children()
@onready var sprites = $Sprites.get_children()
@onready var collisions = $Collisions.get_children()


signal create_platform

var current_direction = 0

var speed_mult = 30.0
var jump_mult = -30.0
var can_double_jump = true
var can_move = true
var vuln = true

var air_time = 0.0

var is_gravity = false
var is_in_gravity_area:= false

var flip_h = false
var current_animation: String

func _ready() -> void:
	change_character()
	sprite.material.set_shader_parameter("output_palette_texture",SaveLoad.save_file.weapon.palette)
	SaveLoad.save_file.connect("update",update_inventory)

func _physics_process(delta: float) -> void:
	Globals.player_pos = global_position
	
	if (velocity.y>0 and (not is_gravity or not is_in_gravity_area)) or (velocity.y<0 and is_gravity):
		sprite.play("fall")
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
		print("monitoring")
		for body in attack_1_area.get_overlapping_bodies():
			print(body)
			if "hit" in body:
				body.hit(SaveLoad.save_file.attack)
	else:
		print("not")

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
	if sprite.flip_h:
		attack_1_area.scale.x = -1
	else:
		attack_1_area.scale.x = 1
	for animation in sprites:
		animation.hide()
	sprite.show()
	animation_player = animations[SaveLoad.save_file.player_selected]


func update_inventory():
	sprite.material.set_shader_parameter("output_palette_texture",SaveLoad.save_file.weapon.palette)

#func _on_attack_1_area_body_entered(body: Node2D) -> void:
	#if "hit" in body:
		#body.hit(Globals.damage)
#
#func _on_attack_2_area_body_entered(body: Node2D) -> void:
	#if "hit" in body:
		#body.hit(Globals.damage)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("create") and SaveLoad.save_file.can_platform and SaveLoad.save_file.player_selected == 0 and $StateMachine.current_state not in [$StateMachine/Attack1,$StateMachine/Attack2,$StateMachine/Attack3,$StateMachine/Idle,$StateMachine/JumpAttack1,$StateMachine/JumpAttack2,$StateMachine/CrouchAttack]:
		create_platform.emit()
	
	if Input.is_action_just_pressed("gravity") and SaveLoad.save_file.can_gravity and SaveLoad.save_file.player_selected == 2:
		is_gravity = !is_gravity
		
	if $StateMachine.current_state not in [$StateMachine/Attack1,$StateMachine/Attack2,$StateMachine/Attack3,$StateMachine/CrouchAttack,$StateMachine/JumpAttack1,$StateMachine/JumpAttack2]:
		if Input.is_action_just_pressed("lb"):
			change_character_left()
		if Input.is_action_just_pressed("rb"):
			change_character_right()

func shade(color):
	$WallParticles.emitting = true
	var tween = create_tween()
	tween.tween_method(set_progress_value,0.0,0.8,0.2)
	$PointLight2D.enabled = true
	#sprite.material.set_shader_parameter("progress", 0.8);	

func unshade():
	$WallParticles2.emitting = (true)
	var tween = create_tween()
	tween.tween_method(set_progress_value,0.8,0.0,0.2)
	#sprite.material.set_shader_parameter("progress", 0.0);
	$PointLight2D.enabled = false

func hurt(damage,pos):
	if vuln and not invicibility:
		attack_1_area.monitoring = false
		var direction = (global_position - pos).normalized()
		hit_timer.start()
		Globals.health -= damage
		can_move = false
		var tween = create_tween()
		tween.tween_property(self, "global_position",global_position+Vector2(direction.x, -0.5)*40,0.2).set_ease(Tween.EASE_OUT)
		vuln = false
		hit_timer.start()
		await tween.finished
		can_move = true
		sprite.visible = false
		await get_tree().create_timer(0.1).timeout
		sprite.visible = true
		await get_tree().create_timer(0.1).timeout
		sprite.visible = false
		await get_tree().create_timer(0.1).timeout
		sprite.visible = true
		await get_tree().create_timer(0.1).timeout
		sprite.visible = false
		await get_tree().create_timer(0.1).timeout
		sprite.visible = true
		await get_tree().create_timer(0.1).timeout
		sprite.visible = false
		await get_tree().create_timer(0.1).timeout
		sprite.visible = true

func _on_hit_timer_timeout() -> void:
	vuln = true

func set_progress_value(value: float):
	# in my case i'm tweening a shader on a texture rect, but you can use anything with a material on it
	sprite.material.set_shader_parameter("progress", value);


func _on_attack_timer_timeout() -> void:
	can_attack = true
