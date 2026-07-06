extends State
class_name EnemyHit

@export var boar: CharacterBody2D

@export var hit_timer = 0.5
var timer


func enter():
	var tween = create_tween()
	tween.tween_property(boar,"velocity",Vector2.ZERO,0.2)
	$"../../HitSounds".get_children()[randi() % $"../../HitSounds".get_children().size()].play()
	timer = hit_timer
	boar.health -= boar.damage_taken
	boar.progress_bar.max_value = boar.max_health
	boar.progress_bar.value = boar.health
	boar.progress_bar.show()
	if boar.health <= 0:
		await get_tree().create_timer(0.4).timeout
		SaveLoad.save_file.exp_points += boar.exp_points
		boar.queue_free()
	else:
		boar.sprite.play("hit")
	

func update(delta):
	if timer > 0:
		timer -= delta
	else:
		boar.progress_bar.hide()
		Transitioned.emit(self, "idle")
	
