extends State
class_name EnemyIdle

@export var boar: CharacterBody2D

@export var speed = 100.0

var direction : Vector2
var wander_time : float

func rand_direction():
	direction = Vector2(randi_range(-1,1),0).normalized()
	wander_time = randf_range(1, 3)
	
func enter():
	rand_direction()
	boar.enter.connect(_on_area_enter)
	boar.touch_wall.connect(_on_touch_wall)
	boar.hit_taken.connect(_on_hit_taken)
	
func update(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		rand_direction()

func physics_update(delta):
	if not boar.is_on_floor():
		Transitioned.emit(self,"falling")
	if boar:
		boar.velocity = direction * speed 
		if direction.x == 1:
			boar.sprite.flip_h = true
		elif direction.x == -1:
			boar.sprite.flip_h = false
		if boar.velocity.x == 0:
			boar.sprite.play("idle")
		else:
			boar.sprite.play("walk")

func _on_area_enter():
	if boar.is_on_floor():
		Transitioned.emit(self,"follow")

func _on_touch_wall():
	direction.x = -direction.x
	wander_time = randf_range(1, 3)
	
func _on_hit_taken():
	Transitioned.emit(self, "hit")
