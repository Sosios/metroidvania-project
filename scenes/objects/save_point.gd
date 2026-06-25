extends Area2D

@export_file("*.tscn") var room: String = ""

func _on_body_entered(body: Node2D) -> void:
	SaveLoad.save_file.current_room = room
	SaveLoad._save()
	Globals.health = SaveLoad.save_file.max_health
