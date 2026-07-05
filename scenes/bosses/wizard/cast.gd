extends State

var boss: CharacterBody2D

func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	if Globals.player_pos.x < boss.global_position.x:
		boss.sprite.flip_h = true
	else:
		boss.sprite.flip_h = false
	boss.sprite.play("cast")
	boss.animation_player.play("cast_spell")


func transition():
	Transitioned.emit(self,"idle")
