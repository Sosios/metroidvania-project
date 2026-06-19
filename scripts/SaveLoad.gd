extends Node

var save_file : Save

const save_location := "user://SaveFile.tres"

#var contents_to_save: Dictionary = {
	#"progress_bar_value": 0.0,
	#"current_room" : "",
	#"discovered_rooms" : [0],
	#"opened_chests" : [],
	#"can_double_jump" : false,
	#"can_dash" : false,
	#"can_platform" : false,
	#"can_gravity" : false,
	#"max_health" : 100,
	#"level" : 1
#}

func _ready() -> void:
	save_file = load("res://inventory/SaveFile.tres").duplicate()
	#_load()

func _save():
	var error := ResourceSaver.save(save_file, save_location)
	if error != OK:
		push_error("Erreur lors de la sauvegarde.")
	
func _load():
	if FileAccess.file_exists(save_location):
		save_file = ResourceLoader.load(save_location)
		
