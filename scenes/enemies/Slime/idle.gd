extends State

var slime: CharacterBody2D

var wander_time : float
var timer : float

func rand_direction():
	slime.direction = Vector2([-1,-1,0,1,1].pick_random(),0).normalized()
	wander_time = randf_range(1, 3)
	
func enter():
	slime = get_parent().get_parent()
	print("IDLE ENTERED")
	timer = 1.0
	var tween = create_tween()
	tween.tween_property(slime,"scale",Vector2.ONE,0.2)
	slime.sprite.play("idle")
	slime.hurt_box.monitoring = true
	rand_direction()
	if not slime.hit_taken.is_connected(_on_hit_taken):
		slime.hit_taken.connect(_on_hit_taken)
	slime.velocity = Vector2.ZERO
	
func update(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		rand_direction()

func physics_update(delta):
	if slime.detect:
		timer -= delta
		if timer <=0:
			Transitioned.emit(self,"attack")
	if slime:
		slime.velocity = slime.direction * slime.speed 
		if slime.direction.x != 0 :
			slime.sprite.play("walk")
		else:
			slime.sprite.play("idle")
		if slime.direction.x == 1:
			slime.sprite.flip_h = false
		elif slime.direction.x == -1:
			slime.sprite.flip_h = true


func _on_touch_wall():
	slime.direction.x = -slime.direction.x
	wander_time = randf_range(1, 3)
	rand_direction()
	
func _on_hit_taken():
	Transitioned.emit(self, "hit")


func _on_direction_change_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
