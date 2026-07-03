extends State
class_name GolluxDead

var boss: CharacterBody2D

var timer: float

func _ready() -> void:
	boss = get_parent().get_parent()

func enter():
	boss.velocity.x = 0.0
	boss.sprite.play("hit")
	var tween = create_tween()
	tween.tween_property(boss.sprite,"modulate:a",0,0.5)
	await tween.finished
	boss.queue_free()
	SaveLoad.save_file.defeated_bosses.append(0)
	SaveLoad.save_file.unlocked_doors.append(1)
	SaveLoad.save_file.unlocked_doors.append(3)
	Globals.show_bar = false
