extends Node
class_name State

signal Transitioned


func get_player() -> CharacterBody2D:
	return get_parent().get_parent() as CharacterBody2D

func enter():
	pass

func exit():
	pass

func update(_delta):
	pass

func physics_update(_delta):
	pass

func useless_function():
	Transitioned.emit()
