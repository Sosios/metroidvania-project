extends State

var skeleton: CharacterBody2D

var wander_time : float
var timer : float

func rand_direction():
	skeleton.direction = Vector2([-1,-1,0,1,1].pick_random(),0).normalized()
	wander_time = randf_range(1, 3)
	
func enter():
	skeleton = get_parent().get_parent()
	print("IDLE ENTERED")
	timer = 1.0
	var tween = create_tween()
	tween.tween_property(skeleton,"scale",Vector2.ONE,0.2)
	skeleton.sprite.play("idle")
	skeleton.hurt_box.monitoring = true
	rand_direction()
	if not skeleton.hit_taken.is_connected(_on_hit_taken):
		skeleton.hit_taken.connect(_on_hit_taken)
	skeleton.velocity = Vector2.ZERO
	
func update(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		rand_direction()

func physics_update(delta):
	if skeleton.detect:
		timer -= delta
		if timer <=0:
			Transitioned.emit(self,"attack")
	if skeleton:
		skeleton.velocity = skeleton.direction * skeleton.speed 
		if skeleton.direction.x != 0 :
			skeleton.sprite.play("walk")
		else:
			skeleton.sprite.play("idle")
		if skeleton.direction.x == 1:
			skeleton.sprite.flip_h = false
		elif skeleton.direction.x == -1:
			skeleton.sprite.flip_h = true


func _on_touch_wall():
	skeleton.direction.x = -skeleton.direction.x
	wander_time = randf_range(1, 3)
	rand_direction()
	
func _on_hit_taken():
	Transitioned.emit(self, "hit")


func _on_direction_change_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
