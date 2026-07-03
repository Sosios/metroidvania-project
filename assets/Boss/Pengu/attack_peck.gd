extends State

var boss: CharacterBody2D

@export var animation_player: AnimationPlayer

func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	boss.sprite.play("attack_peck")
	if boss.sign == 1.0:
		boss.animation_player.play("attack_peck_right")
	else:
		boss.animation_player.play("attack_peck_left")


func transition():
	Transitioned.emit(self,"idle")
