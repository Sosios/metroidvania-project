extends Area2D
class_name CellDiscover

@export var id = 0

@export var color: Color = Color(1.0, 1.0, 1.0, 1.0)

@export var change_color := false

@export var save_id := 0



func _on_body_entered(body: Node2D) -> void:
	Globals.current_room = id
	if id not in SaveLoad.save_file.discovered_rooms:
		SaveLoad.save_file.discover_room(id)
	if change_color:
		var tween =create_tween()
		tween.tween_property(Globals,"screen_color",color,0.5)
