extends State
class_name GolluxAttack1

var boss: CharacterBody2D

@export var animation_player: AnimationPlayer

func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	boss.sprite.play("attack_1")
	animation_player.play("attack_1")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Transitioned.emit(self,"idle")
