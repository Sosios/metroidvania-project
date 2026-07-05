extends Control

@onready var text: Label = $NinePatchRect/MarginContainer2/Text
@onready var title: Label = $NinePatchRect/MarginContainer/Name
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var tween
@export var is_ready = false

func _ready() -> void:
	text.visible_ratio = 0
	

func show_text():
	tween = create_tween()
	tween.tween_property(text,"visible_ratio",1,text.get_total_character_count()*0.015)

func _process(_delta) -> void:
	if is_ready:
		if Input.is_action_just_pressed("ui_accept"):
			if tween.is_valid():
				tween.kill()
			if text.visible_ratio != 1:
				text.visible_ratio = 1
			else:
				animation_player.play("appear",-1,-2.5,true)
				await get_tree().create_timer(0.7).timeout
				Globals.next_dialogue.emit()
				queue_free()
			
