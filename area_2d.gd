extends Area2D

@export var damage: float = 0.0

func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if "hit" in body:
			body.hit(damage)
		if "hurt" in body:
			body.hurt(0,global_position)
			Globals.health = Globals.health * 0.9
