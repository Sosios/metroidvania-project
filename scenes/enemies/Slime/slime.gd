extends CharacterBody2D

@export_enum("0","1","2","3") var type = "0"

signal hit_taken

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var speed = 50.0
var health : float = 15.0
var max_health: float = 15.0
var exp_points: float = 10.0
var damage_given := 10.0
var damage_taken: float
var jump_requested := false
var direction : Vector2 = Vector2(1,0)

@onready var hurt_box: Area2D = $HurtBox
@onready var direction_change_area: Area2D = $DirectionChangeArea

var detect := false

func _ready() -> void:
	match(type):
		"0":
			health = 25.0
			max_health = 25.0
			exp_points = 10.0
			damage_given = 10.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Slime_Enemy_Pixel_Monsters_Vol_1/Slime/spritesheets/blue/palette.png"))
		"1":
			health = 55.0
			max_health = 55.0
			exp_points = 40.0
			damage_given = 20.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Slime_Enemy_Pixel_Monsters_Vol_1/Slime/spritesheets/blue/palette_02.png"))
		"2":
			health = 155.0
			max_health = 155.0
			exp_points = 130.0
			damage_given = 50.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Slime_Enemy_Pixel_Monsters_Vol_1/Slime/spritesheets/blue/palette_03.png"))
		"3":
			health = 325.0
			max_health = 325.0
			exp_points = 250.0
			damage_given = 100.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Slime_Enemy_Pixel_Monsters_Vol_1/Slime/spritesheets/blue/palette_04.png"))
	progress_bar.value = health
	progress_bar.hide()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if jump_requested:
		velocity.y = -400.0
		jump_requested = false
	move_and_slide()
	for body in hurt_box.get_overlapping_bodies():
		if "hurt" in body:
			body.hurt(damage_given,global_position)

	
	
func _on_detect_area_body_entered(body: Node2D) -> void:
	detect = true


func _on_detect_area_body_exited(body: Node2D) -> void:
	detect = false

func hit(damage):
	hit_taken.emit()
	damage_taken = damage
