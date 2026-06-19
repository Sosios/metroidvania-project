@tool
extends Area2D

@export var id = 0

func _on_body_entered(body: Node2D) -> void:
	Globals.current_room = id
	if id not in SaveLoad.save_file.discovered_rooms:
		SaveLoad.save_file.discover_room(id)
