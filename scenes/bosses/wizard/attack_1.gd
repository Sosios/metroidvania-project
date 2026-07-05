extends State

var boss: CharacterBody2D


func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	boss.sprite.play("attack_1")
	if !boss.sprite.flip_h:
		boss.animation_player.play("attack_1_right")
	else:
		boss.animation_player.play("attack_1_left")


func transition():
	Transitioned.emit(self,"idle")
