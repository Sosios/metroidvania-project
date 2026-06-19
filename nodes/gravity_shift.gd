extends Area2D

@export var degrees: float
@export var direction: String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.is_in_gravity_area = true
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.is_in_gravity_area = false
