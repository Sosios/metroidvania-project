extends State

var wolf: CharacterBody2D

func enter():
	wolf = get_parent().get_parent()
	wolf.sprite.play("idle")
	var tween =create_tween()
	tween.tween_property(wolf,"velocity",Vector2(0.0,wolf.velocity.y),0.1)
	wolf.velocity.y = 0
	if wolf.detect:
		wolf.attack_timer.start()
	if not wolf.hit_taken.is_connected(_on_hit_taken):
		wolf.hit_taken.connect(_on_hit_taken)

func physics_update(delta):
	wolf.velocity.x = move_toward(wolf.velocity.x, 0, 1.0)
	wolf.move_and_slide()

func _on_hit_taken():
	Transitioned.emit(self,"hit")

func _on_attack_timer_timeout() -> void:
	if wolf and wolf.detect:
		Transitioned.emit(self,"attack")
		
func exit():
	wolf.attack_timer.stop()
