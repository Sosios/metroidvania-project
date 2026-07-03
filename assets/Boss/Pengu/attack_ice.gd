extends State



var boss: CharacterBody2D

@export var animation_player: AnimationPlayer

func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	if Globals.player_pos.x < boss.global_position.x:
		boss.sprite.flip_h = true
	else:
		boss.sprite.flip_h = false
	boss.sprite.play("attack_ice")
	boss.animation_player.play("attack_ice")


func transition():
	Transitioned.emit(self,"idle")
