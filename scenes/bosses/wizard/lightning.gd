extends Area2D

@export var shake:= false:
	set(value):
		shake = value
		Globals.shake = shake

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if "hurt" in body:
		body.hurt(250, global_position)
