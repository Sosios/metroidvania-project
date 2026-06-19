extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if "shade" in body:
		body.shade("ff0000")


func _on_body_exited(body: Node2D) -> void:
	if "unshade" in body:
		body.unshade()
