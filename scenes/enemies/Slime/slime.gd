extends CharacterBody2D


signal touch_wall
signal hit_taken

@export var speed = 100.0
@onready var health : float = 15.0
@onready var max_health: float = 15.0
@onready var exp_points: float = 10.0
@onready var damage_taken: float

@onready var hurt_box: Area2D = $HurtBox
@onready var direction_change_area: Area2D = $DirectionChangeArea
@onready var progress_bar: ProgressBar = $ProgressBar


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	for body in hurt_box.get_overlapping_bodies():
		if "hurt" in body and $StateMachine.current_state == $StateMachine/Idle:
			body.hurt(10,global_position)

	
func _on_direction_change_area_body_entered(_body: Node2D) -> void:
	touch_wall.emit()
	
func hit(damage):
	hit_taken.emit()
	damage_taken = damage
