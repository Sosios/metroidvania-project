extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var attack_1_area: Area2D = $Attack1Area
@onready var attack_2_area: Area2D = $Attack2Area

@onready var hit_timer: Timer = $Timers/HitTimer

@onready var state_machine: Node = $StateMachine

@export var speed = 10.0
@export var jump_velocity = 10.0



signal create_platform

var speed_mult = 30.0
var jump_mult = -30.0
var can_double_jump = true
var can_move = true
var vuln = true

var is_gravity = false
var is_in_gravity_area:= false

func _ready() -> void:
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
	
	if Input.is_action_just_pressed("create"):
		create_platform.emit()
	
	if Input.is_action_just_pressed("gravity"):
		is_gravity = !is_gravity
		
	
	move_and_slide()
	if $Attack1Area.monitoring:
		for body in $Attack1Area.get_overlapping_bodies():
			if "hit" in body:
				body.hit(SaveLoad.save_file.attack)
	if $Attack2Area.monitoring:			
		for body in $Attack2Area.get_overlapping_bodies():
			if "hit" in body:
				body.hit(SaveLoad.save_file.attack)




func update_inventory():
	sprite.material.set_shader_parameter("output_palette_texture",SaveLoad.save_file.weapon.palette)

#func _on_attack_1_area_body_entered(body: Node2D) -> void:
	#if "hit" in body:
		#body.hit(Globals.damage)
#
#func _on_attack_2_area_body_entered(body: Node2D) -> void:
	#if "hit" in body:
		#body.hit(Globals.damage)

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
	if vuln:
		var direction = (global_position - pos).normalized()
		hit_timer.start()
		Globals.health -= damage
		can_move = false
		var tween = create_tween()
		tween.tween_property(self, "global_position",global_position+Vector2(direction.x, -0.75)*20,0.2).set_ease(Tween.EASE_OUT)
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
