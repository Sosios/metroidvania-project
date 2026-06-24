extends Enemy


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


signal enter

signal exit

signal touch_wall

signal hit_taken

@onready var progress_bar: ProgressBar = $ProgressBar

var damage_taken : float

var health = 25.0

var max_health = 25.0

@export var exp_points:float = 25.0

func _ready() -> void:
	
	sprite.play("walk")
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
			body.hurt(10,global_position)


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
