extends Enemy


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


signal enter

signal exit

signal touch_wall

signal hit_taken

signal update_health

var damage_taken : float

@export var max_health = 1200.0

var health = max_health:
	set(value):
		health = value
		Globals.boss_health = health

@export var exp_points:float = 200.0

@export var speed:float = 100.0

@export var vuln: bool = true

@export var shield: bool = false

@export var strength: float = 50.0

@onready var navigation: NavigationAgent2D = $NavigationAgent2D

@onready var target_position:= Vector2.ZERO

@onready var hitboxes:= $Hitbox.get_children()


@export var shake:= false:
	set(value):
		shake = value
		Globals.shake = shake

func _ready() -> void:
	sprite.flip_h = true
	Globals.show_bar = true
	Globals.boss_name = "Gollux"
	Globals.boss_health = health
	Globals.boss_max_health = max_health
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	for body in $Hitbox.get_overlapping_bodies():
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
