extends State

var player: CharacterBody2D

func enter():
	player = get_parent().get_parent()
	player.sprite.play("dead")
	player.dead_voices[SaveLoad.save_file.player_selected].play()
	await player.sprite.animation_finished
	SaveLoad._load()
	TransitionLayer.change_scene("res://scenes/levels/game_over.tscn")
	Globals.health = SaveLoad.save_file.max_health
	Globals.show_bar = false
