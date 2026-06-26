extends Area2D

@export var damage: float = 10.0

func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if "hit" in body:
			body.hit(body.max_health * 0.2)
		if "hurt" in body:
			body.hurt(SaveLoad.save_file.max_health * 0.1,Globals.player_pos+Vector2.DOWN)
