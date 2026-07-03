extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if "hurt" in body:
		body.hurt(100, global_position)
