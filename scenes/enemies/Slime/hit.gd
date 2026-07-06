extends State

var slime: CharacterBody2D

var hit_timer = 0.5
var timer


func enter():
	slime = get_parent().get_parent()
	timer = hit_timer
	if Engine.time_scale == 1:
		Engine.time_scale = 0.05
		await get_tree().create_timer(0.015).timeout
		Engine.time_scale = 1
	slime.velocity = Vector2.ZERO
	$"../../HitSounds".get_children()[randi() % $"../../HitSounds".get_children().size()].play()
	slime.health -= slime.damage_taken
	slime.progress_bar.max_value = slime.max_health
	slime.progress_bar.value = slime.health
	slime.progress_bar.show()
	slime.hurt_box.monitoring = false
	if slime.health <= 0:
		var tween = create_tween()
		tween.tween_property(slime.sprite,"modulate:a",0,0.4)
		await get_tree().create_timer(0.4).timeout
		slime.sprite.play("dead")
		SaveLoad.save_file.exp_points += slime.exp_points
		slime.queue_free()
	else:
		slime.sprite.material.set_shader_parameter("progress", 0.8)
		slime.sprite.play("hit")

func update(delta):
	if not is_instance_valid(slime):
		return
	slime.velocity.x = move_toward(slime.velocity.x,0,0.1)
	if timer > 0:
		timer -= delta
	else:
		slime.sprite.material.set_shader_parameter("progress", 0) 
		slime.progress_bar.hide()
		Transitioned.emit(self, "idle")
	
