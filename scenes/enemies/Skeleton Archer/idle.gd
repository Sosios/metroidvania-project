extends State

var skeleton: CharacterBody2D

var wander_time : float
var timer : float

func rand_direction():
	skeleton.direction = [-1,-1,0,1,1].pick_random()
	wander_time = randf_range(1, 3)
	
func enter():
	skeleton = get_parent().get_parent()
	skeleton.sprite.play("move")
	timer = 1.0
	skeleton.hurt_box.monitoring = true
	rand_direction()
	if not skeleton.hit_taken.is_connected(_on_hit_taken):
		skeleton.hit_taken.connect(_on_hit_taken)
	if not skeleton.touch_wall.is_connected(_on_hit_taken):
		skeleton.touch_wall.connect(_on_touch_wall)
	
func update(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		rand_direction()

func physics_update(delta):
	if skeleton.detect:
		timer -= delta
		if timer <=0:
			if skeleton.arrow:
				Transitioned.emit(self,"attack")
			else:
				Transitioned.emit(self,"reload")
	if skeleton:
		skeleton.velocity.x = skeleton.direction * skeleton.speed 
		if skeleton.direction == 1:
			skeleton.sprite.flip_h = false
		elif skeleton.direction == -1:
			skeleton.sprite.flip_h = true


func _on_touch_wall():
	skeleton.direction.x = -skeleton.direction.x
	wander_time = randf_range(1, 3)
	rand_direction()
	
func _on_hit_taken():
	Transitioned.emit(self, "hit")

func exit():
	skeleton.velocity.x = 0.0
