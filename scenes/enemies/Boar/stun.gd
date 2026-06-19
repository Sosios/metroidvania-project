extends State
class_name EnemyStun

@export var boar: CharacterBody2D

@export var hit_timer = 0.1
var timer


func enter():
	timer = hit_timer

func update(delta):
	if timer > 0:
		timer -= delta
	else:
		boar.progress_bar.hide()
		Transitioned.emit(self, "idle")
		print("emit idle")
	if boar.health <= 0:
		await get_tree().create_timer(0.4).timeout
		SaveLoad.save_file.exp_points += boar.exp_points
		boar.queue_free()
