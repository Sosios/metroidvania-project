extends State
class_name GolluxAttack2

var boss: CharacterBody2D

@export var animation_player: AnimationPlayer

func _ready() -> void:
	boss = get_parent().get_parent()

func enter() -> void:
	boss.sprite.play("attack_2")
	animation_player.play("attack_2")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Transitioned.emit(self,"idle")
