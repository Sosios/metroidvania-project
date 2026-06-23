@tool
extends Area2D
class_name TransitionArea

@export_file("*.tscn") var target: String = "" 

@export var marker = 0

@export var flip_h = false

@export var jump_up = false

func _on_body_entered(body: Node2D) -> void:
	Globals.marker = marker
	Globals.flip_h = body.sprite.flip_h
	Globals.jump_up = jump_up
	TransitionLayer.change_scene(target)
	
