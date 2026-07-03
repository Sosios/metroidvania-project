extends State

var boss: CharacterBody2D

@export var animation_player: AnimationPlayer

func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	boss.sprite.play("attack")
	if boss.sign == 1.0:
		boss.animation_player.play("attack_right")
	else:
		boss.animation_player.play("attack_left")


func transition() -> void:
	boss.target_position = Globals.player_pos
	var dist = boss.global_position.distance_to(boss.target_position)
	if dist > 250.0:
		Transitioned.emit(self, "move")
	else:
		Transitioned.emit(self,"idle")
