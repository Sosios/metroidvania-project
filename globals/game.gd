extends Node2D

func _ready() -> void:
	TransitionLayer.change_scene(SaveLoad.save_file.current_room)
	
