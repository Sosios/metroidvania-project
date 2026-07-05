extends CharacterBody2D


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export_enum("0","1","2","3") var type = "0"

signal enter

signal exit

signal touch_wall

signal hit_taken

@onready var progress_bar: ProgressBar = $ProgressBar

@export var speed:float = 250.0

@onready var hurt_box: Area2D = $HurtBox

@onready var navigation_timer: Timer = $NavigationTimer

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D



var damage_taken : float

var health: float

var max_health :float

var exp_points:float

func _ready() -> void:
	
	match(type):
		"0":
			health = 5.0
			max_health = 5.0
			exp_points = 10.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Rocky Roads/bat_palette_.png"))
		"1":
			health = 85.0
			max_health = 85.0
			exp_points = 40.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Rocky Roads/bat_palette_02.png"))
		"2":
			health = 125.0
			max_health = 125.0
			exp_points = 100.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Rocky Roads/bat_palette_03.png"))
		"4":
			health = 250.0
			max_health = 250
			exp_points = 200.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Ennemis/Rocky Roads/bat_palette_03.png"))
	progress_bar.value = health
	progress_bar.hide()

func _physics_process(delta: float) -> void:
	
	
	
	move_and_slide()
	for body in hurt_box.get_overlapping_bodies():
		if "hurt" in body:
			body.hurt(10,global_position)


func hit(damage):
	hit_taken.emit()
	damage_taken = damage

func _on_detect_area_body_entered(_body: Node2D) -> void:
	enter.emit()

func _on_detect_area_body_exited(_body: Node2D) -> void:
	exit.emit()



#func _on_hurt_box_body_entered(body: Node2D) -> void:
	#if "hurt" in body and $StateMachine.current_state == $StateMachine/Follow:
		#body.hurt(10,global_position)
