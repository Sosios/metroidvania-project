extends Enemy


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurt_box: Area2D = $AnimatedSprite2D/HurtBox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
signal hit_taken

signal ice_cube(pos)

var damage_taken : float

@export var max_health = 2800.0

var health = max_health:
	set(value):
		health = value
		Globals.boss_health = health

@export var exp_points:float = 200.0

@export var speed:float = 100.0

@export var vuln: bool = true

@export var shield: bool = false

@export var strength: float = 100.0

@onready var target_position:= Vector2.ZERO

var sign : float

@export var shake:= false:
	set(value):
		shake = value
		Globals.shake = shake

func _ready() -> void:
	sprite.flip_h = true
	Globals.show_bar = true
	Globals.boss_name = "Pengu"
	Globals.boss_health = health
	Globals.boss_max_health = max_health
	pass

func send_cube():
	ice_cube.emit(Globals.player_pos)

func _physics_process(delta: float) -> void:
	sign = -1.0 if sprite.flip_h else 1.0
	move_and_slide()
	for body in hurt_box.get_overlapping_bodies():
		if "hurt" in body:
			body.hurt(strength,global_position)


func hit(damage):
	if vuln and not shield:
		$HitSounds.get_children()[randi() % $HitSounds.get_children().size()].play()
		health -= damage
		sprite.material.set_shader_parameter("progress", 0.5)
		await get_tree().create_timer(0.1).timeout
		sprite.material.set_shader_parameter("progress", 0)
		$HitTimer.start()
		vuln = false
	if health <= 0:
		$StateMachine.current_state = $StateMachine/Dead
		$StateMachine.current_state.enter()
		Music.music.stop()
#func _on_hurt_box_body_entered(body: Node2D) -> void:
	#if "hurt" in body and $StateMachine.current_state == $StateMachine/Follow:
		#body.hurt(10,global_position)


func _on_hit_timer_timeout() -> void:
	vuln = true
