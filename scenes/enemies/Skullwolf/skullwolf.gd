extends CharacterBody2D

signal hit_taken

@onready var sprite: AnimatedSprite2D = $Sprite

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var attack_timer: Timer = $AttackTimer
@onready var hurt_box: Area2D = $HurtBox

var damage_taken : float
var health = 45.0
var max_health = 45.0
@export var exp_points:float = 30.0

var detect := false



func _ready():
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.hide()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	for body in hurt_box.get_overlapping_bodies():
		if "hurt" in body:
			body.hurt(30,global_position)
	
func hit(damage):
	hit_taken.emit()
	damage_taken = damage

func _on_detect_area_body_entered(body: Node2D) -> void:
	detect = true
	attack_timer.start()


func _on_detect_area_body_exited(body: Node2D) -> void:
	detect = false
