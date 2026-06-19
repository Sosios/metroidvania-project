extends State
class_name EnemyFollow

@export var boar: CharacterBody2D

@export var speed = 250
var playerselected : CharacterBody2D
var direction: float

func enter():
	playerselected = get_tree().get_first_node_in_group("Player")
	boar.exit.connect(_on_area_exit)
	boar.hit_taken.connect(_on_hit_taken)

func physics_update(delta):
	if not boar.is_on_floor():
		Transitioned.emit(self,"falling")
	var tween = create_tween()
	if (Globals.player_pos.x - boar.global_position.x) > 0:
		direction = 1.0
	elif (Globals.player_pos.x - boar.global_position.x) < 0:
		direction = -1.0
	if abs(Globals.player_pos.x - boar.global_position.x) < 35:
		tween.tween_property(boar,"velocity",Vector2(0,0),0.2)
		#boar.velocity.x = 0
		boar.sprite.play("idle")
	else:
		tween.tween_property(boar,"velocity",Vector2(direction * speed,0),0.2)
		#boar.velocity.x = direction * speed
		boar.sprite.play("run")

func _on_area_exit():
	Transitioned.emit(self,"idle")
	


func _on_hit_taken():
	Transitioned.emit(self, "hit")
	print("emit hit")
