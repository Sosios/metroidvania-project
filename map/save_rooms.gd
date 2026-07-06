extends Node2D

func _ready() -> void:
	for button in get_children():
		button.get_child(0).hide()
		button.focus_mode = Control.FOCUS_NONE
	if get_parent().type == 1:
		for button in get_children():
			button.get_child(0).hide()
			button.focus_mode = Control.FOCUS_NONE
			if button.id in SaveLoad.save_file.discovered_save_rooms:
				button.focus_mode = Control.FOCUS_ALL
		get_parent().map_rooms.zoom = false
