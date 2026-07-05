extends State

var jump := -300

var timer: float

var slime: CharacterBody2D 

var speed := 25.0

func enter():
	timer = 1.0
	slime = get_parent().get_parent()
	slime.sprite.play("bounce")
	slime.direction = (Globals.player_pos - slime.global_position).normalized()
	slime.sprite.flip_h = slime.direction.x > 0
	slime.velocity.x = slime.direction.x * speed
	slime.jump_requested = true
	slime.hurt_box.position.x = abs(slime.hurt_box.position.x) * slime.direction.x
	if not slime.hit_taken.is_connected(_on_hit_taken):
		slime.hit_taken.connect(_on_hit_taken)

func _on_hit_taken():
	Transitioned.emit(self,"hit")

func physics_update(delta):
	#print("attack timer: ", timer, " on_floor: ", slime.is_on_floor())
	if timer > 0:
		timer -= delta
	else:
		if slime.is_on_floor():
			slime.velocity.x = 0
			await get_tree().create_timer(0.2).timeout
			slime.sprite.scale = Vector2(1.3,0.7)
			Transitioned.emit(self,"idle")
