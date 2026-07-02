extends State

@export var slime: CharacterBody2D

@export var hit_timer = 0.5
var timer


func enter():
	var tween = create_tween()
	tween.tween_property(slime,"velocity",Vector2.ZERO,0.2)
	timer = hit_timer
	slime.velocity = Vector2.ZERO
	slime.health -= slime.damage_taken
	slime.progress_bar.max_value = slime.max_health
	slime.progress_bar.value = slime.health
	slime.progress_bar.show()
	slime.hurt_box.monitoring = false
	slime.sprite.material.set_shader_parameter("progress", 0.8)
	slime.sprite.play("hit")

func update(delta):
	if timer > 0:
		timer -= delta
	else:
		slime.sprite.material.set_shader_parameter("progress", 0) 
		slime.progress_bar.hide()
		Transitioned.emit(self, "idle")
	if slime.health <= 0:
		slime.sprite.play("dead")
		var tween = create_tween()
		tween.tween_property(slime.sprite,"modulate:a",0,0.4)
		await get_tree().create_timer(0.4).timeout
		SaveLoad.save_file.exp_points += slime.exp_points
		slime.queue_free()
