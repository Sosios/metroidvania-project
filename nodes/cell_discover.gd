extends Area2D
class_name CellDiscover

signal new_zone_ui

@export var id = 0

@export_enum("normal_room","save_room") var type = "normal_room"

@export var color: Color = Color(1.0, 1.0, 1.0, 1.0)

@export var change_color := false

@export var save_id := 0

@export var new_zone := false

@export var zone_name := ""

@export var play_new_music := false

@export var play_new_ambience := false

@export var stop_music := false

@export var music : AudioStream

@export var ambience : AudioStream

func _on_body_entered(body: Node2D) -> void:
	Globals.current_room = id
	if id not in SaveLoad.save_file.discovered_rooms:
		SaveLoad.save_file.discover_room(id)
	if type == "save_room":
		if id not in SaveLoad.save_file.discovered_save_rooms:
			SaveLoad.save_file.discovered_save_rooms.append(save_id)
	if change_color:
		var tween = create_tween()
		tween.tween_property(Globals,"screen_color",color,0.5)
	Globals.current_save_room = save_id
	if stop_music:
		Music.music.stop()
		Music.ambience.stop()
	if play_new_music:
		if not Music.music.is_playing():
			Music.music.stream = music
			Music.music.play()
	if play_new_ambience:
		if not Music.ambience.is_playing():
			Music.ambience.stream = ambience
			Music.ambience.play()
	if new_zone:
		if zone_name not in SaveLoad.save_file.discovered_zones:
			Globals.new_zone = true
			Globals.zone_name = zone_name
