extends Area2D

@export var damage: float = 0.0

func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if "hit" in body:
			body.hit(damage)
		if "hurt" in body:
			body.hurt(SaveLoad.save_file.max_health * 0.1,global_position)
