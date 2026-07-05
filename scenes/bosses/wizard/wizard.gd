extends CharacterBody2D


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


@onready var hurt_box: Area2D = $HurtBox
@export var hurt := 150.0

@onready var hit_box: Area2D = $HitBox
@export var strength := 250.0

signal spell_cast(pos)

var damage_taken : float

@export var max_health = 5000.0

var health = max_health:
	set(value):
		health = value
		Globals.boss_health = health

@export var exp_points:float = 300.0

@export var speed:float = 100.0

@export var vuln: bool = true

@export var shield: bool = false


@onready var target_position:= Vector2.ZERO



var sign : float

func show_dialogue():
	$DialogueSpawn/CollisionShape2D.global_position = sprite.global_position
	await Globals.final_dialogue
	TransitionLayer.change_scene("res://scenes/levels/ending.tscn")

	

func _ready() -> void:
	var level = get_tree().current_scene
	sprite.flip_h = true
	Globals.show_bar = true
	Globals.boss_name = "Mage noir"
	Globals.boss_health = health
	Globals.boss_max_health = max_health
	pass

func cast_spell():
	Globals.boss_spell_cast.emit(global_position)

func _physics_process(delta: float) -> void:
	sign = 1.0 if sprite.flip_h else -1.0
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	for body in hurt_box.get_overlapping_bodies():
		if "hurt" in body:
			body.hurt(hurt,global_position)
	for body in hit_box.get_overlapping_bodies():
		if "hurt" in body:
			body.hurt(strength,global_position)


func hit(damage):
	if vuln and not shield:
		health -= damage
		sprite.material.set_shader_parameter("progress", 0.5)
		await get_tree().create_timer(0.1).timeout
		sprite.material.set_shader_parameter("progress", 0)
		$HitTimer.start()
		vuln = false
	if health <= 0:
		$StateMachine.current_state = $StateMachine/Dead
		$StateMachine.current_state.enter()
#func _on_hurt_box_body_entered(body: Node2D) -> void:
	#if "hurt" in body and $StateMachine.current_state == $StateMachine/Follow:
		#body.hurt(10,global_position)


func _on_hit_timer_timeout() -> void:
	vuln = true
