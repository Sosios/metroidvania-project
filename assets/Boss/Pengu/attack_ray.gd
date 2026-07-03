extends State

var boss: CharacterBody2D


func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	boss.sprite.play("attack_ray")
	if boss.sign == 1.0:
		boss.animation_player.play("attack_ray_right")
	else:
		boss.animation_player.play("attack_ray_left")


func transition():
	Transitioned.emit(self,"idle")
