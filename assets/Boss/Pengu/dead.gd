extends State

var boss: CharacterBody2D

var timer: float

func _ready() -> void:
	boss = get_parent().get_parent()

func enter():
	boss.velocity.x = 0.0
	boss.sprite.play("hit")
	var tween = create_tween()
	tween.tween_property(boss.sprite,"modulate:a",0,0.5)
	boss.hurt_box.monitoring = false
	await get_tree().create_timer(0.5).timeout
	boss.queue_free()
	SaveLoad.save_file.defeated_bosses.append(2)
	SaveLoad.save_file.unlocked_doors.append(9)
	SaveLoad.save_file.unlocked_doors.append(10)
	Globals.show_bar = false
