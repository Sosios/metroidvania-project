extends State

@export var bat :CharacterBody2D

func enter():
	bat.velocity = Vector2.ZERO
	bat.connect("enter", detect)
	
func detect():
	Transitioned.emit(self,"fly")
	
