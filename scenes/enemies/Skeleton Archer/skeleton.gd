extends CharacterBody2D

signal hit_taken

signal touch_wall

signal send_arrow(pos,damage)

@onready var arrow_spawn: Marker2D = $AnimatedSprite2D/ArrowSpawn
@onready var arrow_spawn_2: Marker2D = $AnimatedSprite2D/ArrowSpawn2
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed := 30.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


@export_enum("0","1","2") var type = "0"

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var hurt_box: Area2D = $HurtBox

var damage_taken : float
var health = 45.0
var max_health = 45.0
@export var exp_points:float = 30.0

var damage_given := 30.0
var arrow_damage := 40.0

var detect := false

var arrow := true

var standing = true

var direction := 1

func attack():
	send_arrow.emit(arrow_spawn.global_position,arrow_damage)
		
func attack_low():
	send_arrow.emit(arrow_spawn_2.global_position,arrow_damage)

func _ready():
	match(type):
		"0":
			health = 45.0
			max_health = 45.0
			exp_points = 50.0
			damage_given = 20.0
			arrow_damage = 40.0
			#sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Skullwolf/palette.png"))
		"1":
			health = 112.0
			max_health = 115.0
			exp_points = 100.0
			damage_given = 120.0
			arrow_damage = 180.0
			#sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Skullwolf/palette_02.png"))
		"2":
			health = 250.0
			max_health = 250.0
			exp_points = 200.0
			damage_given = 240.0
			arrow_damage = 360.0
			#sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Skullwolf/palette_04.png"))
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.hide()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	if hurt_box.monitoring:
		for body in hurt_box.get_overlapping_bodies():
			if "hurt" in body:
				body.hurt(damage_given,global_position)
	
func hit(damage):
	hit_taken.emit()
	damage_taken = damage

func _on_detect_area_body_entered(body: Node2D) -> void:
	detect = true


func _on_detect_area_body_exited(body: Node2D) -> void:
	detect = false


func _on_direction_change_area_body_entered(body: Node2D) -> void:
	touch_wall.emit()
