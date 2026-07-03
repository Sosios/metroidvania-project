extends State

var wolf:CharacterBody2D

var timer
var hit_timer := 0.5

func enter():
	wolf = get_parent().get_parent()
	timer = hit_timer
	
	wolf.health -= wolf.damage_taken
	wolf.progress_bar.max_value = wolf.max_health
	wolf.progress_bar.value = wolf.health
	wolf.progress_bar.show()
	
	if wolf.health <= 0:
		wolf.sprite.play("dead")
		var tween = create_tween()
		tween.tween_property(wolf.sprite,"modulate:a",0,0.4)
		await tween.finished
		SaveLoad.save_file.exp_points += wolf.exp_points
		wolf.queue_free()
	else:
		wolf.sprite.play("hit")

func _on_hit_taken():
	Transitioned.emit(self,"hit")

func physics_update(delta):
	if not is_instance_valid(wolf):
		return
	wolf.velocity.x = move_toward(wolf.velocity.x,0,0.5)
	
	if timer >0:
		timer -= delta
	else:
		if wolf.health > 0:
			Transitioned.emit(self,"idle")
			wolf.progress_bar.hide()
