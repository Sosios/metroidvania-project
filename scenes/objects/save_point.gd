extends Area2D

@export_file("*.tscn") var room: String = ""
var can_trigger: = false

func _ready() -> void:
	await get_tree().create_timer(0.3).timeout
	can_trigger = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and can_trigger:
		SaveLoad.save_file.current_room = room
		Globals.save_ui.emit()
