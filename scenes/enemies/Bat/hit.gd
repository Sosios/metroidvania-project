extends State

@export var bat: CharacterBody2D

@export var hit_timer = 0.5
var timer


func enter():
	timer = hit_timer
	bat.velocity = Vector2.ZERO
	$"../../HitSounds".get_children()[randi() % $"../../HitSounds".get_children().size()].play()
	bat.health -= bat.damage_taken
	bat.progress_bar.max_value = bat.max_health
	bat.progress_bar.value = bat.health
	bat.progress_bar.show()
	bat.hurt_box.monitoring = false
	bat.sprite.material.set_shader_parameter("progress", 0.8)

func update(delta):
	if timer > 0:
		timer -= delta
	else:
		bat.sprite.material.set_shader_parameter("progress", 0) 
		bat.progress_bar.hide()
		Transitioned.emit(self, "fly")
	if bat.health <= 0:
		await get_tree().create_timer(0.4).timeout
		SaveLoad.save_file.exp_points += bat.exp_points
		bat.queue_free()
