extends Enemy


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export_enum("0","1","2","3") var type = "0"


signal enter

signal exit

signal touch_wall

signal hit_taken

@onready var progress_bar: ProgressBar = $ProgressBar

var damage_given := 10.0

var damage_taken : float

var health = 25.0

var max_health = 25.0

@export var exp_points:float = 10.0

func _ready() -> void:
	
	match(type):
		"0":
			health = 25.0
			max_health = 25.0
			exp_points = 10.0
			damage_given = 10.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Legacy-Fantasy - High Forest 2.3/Mob/Boar/palette.png"))
		"1":
			health = 55.0
			max_health = 55.0
			exp_points = 40.0
			damage_given = 20.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Legacy-Fantasy - High Forest 2.3/Mob/Boar/palette_02.png"))
		"2":
			health = 155.0
			max_health = 155.0
			exp_points = 130.0
			damage_given = 50.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Legacy-Fantasy - High Forest 2.3/Mob/Boar/palette_03.png"))
		"3":
			health = 325.0
			max_health = 325.0
			exp_points = 250.0
			damage_given = 100.0
			sprite.material.set_shader_parameter("output_palette_texture",load("res://assets/Legacy-Fantasy - High Forest 2.3/Mob/Boar/palette_04.png"))
	progress_bar.value = health
	progress_bar.hide()

func _physics_process(delta: float) -> void:
	
	if sprite.flip_h:
		$DetectArea.scale.x = -1
	else:
		$DetectArea.scale.x = 1
	
	move_and_slide()
	for body in $HurtBox.get_overlapping_bodies():
		if "hurt" in body and $StateMachine.current_state == $StateMachine/Follow:
			body.hurt(damage_given,global_position)


func hit(damage):
	hit_taken.emit()
	damage_taken = damage

func _on_detect_area_body_entered(_body: Node2D) -> void:
	enter.emit()

func _on_detect_area_body_exited(_body: Node2D) -> void:
	exit.emit()

func _on_direction_change_area_body_entered(_body: Node2D) -> void:
	touch_wall.emit()
	


#func _on_hurt_box_body_entered(body: Node2D) -> void:
	#if "hurt" in body and $StateMachine.current_state == $StateMachine/Follow:
		#body.hurt(10,global_position)
