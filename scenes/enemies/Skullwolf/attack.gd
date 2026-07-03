extends State

var speed := 250.0

var jump := -270

var timer: float

@export var wolf: CharacterBody2D 

func enter():
	timer = 0.1
	wolf = get_parent().get_parent()
	wolf.sprite.play("attack")
	var direction = (Globals.player_pos - wolf.global_position).normalized()
	wolf.sprite.flip_h = direction.x > 0
	wolf.velocity.x += direction.x * speed
	wolf.velocity.y = jump
	wolf.hurt_box.position.x = abs(wolf.hurt_box.position.x) * direction.x
	if not wolf.hit_taken.is_connected(_on_hit_taken):
		wolf.hit_taken.connect(_on_hit_taken)

func _on_hit_taken():
	Transitioned.emit(self,"hit")

func physics_update(delta):
	if timer > 0:
		timer -= delta
	else:
		if wolf.is_on_floor():
			wolf.velocity.x = 0
			wolf.sprite.play("land")
			await get_tree().create_timer(0.2).timeout
			Transitioned.emit(self,"idle")
