extends State
class_name EnemyFalling

@export var boar: CharacterBody2D

func physics_update(delta):
	boar.velocity += boar.get_gravity() * delta
	if boar.is_on_floor():
		Transitioned.emit(self,"idle")
	
