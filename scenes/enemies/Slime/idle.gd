extends State

@export var slime: CharacterBody2D

var direction : Vector2
var wander_time : float

func rand_direction():
	direction = Vector2(randi_range(-1,1),0).normalized()
	wander_time = randf_range(1, 3)
	
func enter():
	slime.sprite.play("default")
	rand_direction()
	slime.hit_taken.connect(_on_hit_taken)
	
func update(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		rand_direction()

func physics_update(delta):
	if slime:
		slime.velocity = direction * slime.speed 
		if direction.x == 1:
			slime.sprite.flip_h = true
		elif direction.x == -1:
			slime.sprite.flip_h = false
		if slime.velocity.x == 0:
			slime.sprite.play("idle")
		else:
			slime.sprite.play("walk")
	slime.move_and_slide()


func _on_touch_wall():
	direction.x = -direction.x
	wander_time = randf_range(1, 3)
	
func _on_hit_taken():
	Transitioned.emit(self, "hit")
