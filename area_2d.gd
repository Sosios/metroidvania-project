extends Area2D

@export var damage: float = 10.0

func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if "hit" in body:
			body.hit(body.health * 0.1)
		if "hurt" in body:
			body.hurt(SaveLoad.save_file.max_health * 0.1,global_position)
