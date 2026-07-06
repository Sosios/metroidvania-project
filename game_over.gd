extends Control

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	load_save()

func load_save():
	SaveLoad._load()
	TransitionLayer.change_scene(SaveLoad.save_file.current_room)
