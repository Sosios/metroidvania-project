extends Node

func _ready() -> void:
	$VBoxContainer/HBoxContainer/SubViewportContainer.show()
	$VBoxContainer/HBoxContainer/New.grab_focus()
	
	


func _on_new_pressed() -> void:
	TransitionLayer.change_scene(SaveLoad.save_file.current_room)


func _on_load_pressed() -> void:
	SaveLoad._load()
	TransitionLayer.change_scene(SaveLoad.save_file.current_room)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_new_focus_exited() -> void:
	$VBoxContainer/HBoxContainer/SubViewportContainer.hide()


func _on_new_focus_entered() -> void:
	$VBoxContainer/HBoxContainer/SubViewportContainer.show()


func _on_load_focus_entered() -> void:
	$VBoxContainer/HBoxContainer2/SubViewportContainer.show()


func _on_load_focus_exited() -> void:
	$VBoxContainer/HBoxContainer2/SubViewportContainer.hide()


func _on_quit_focus_entered() -> void:
	$VBoxContainer/HBoxContainer3/SubViewportContainer.show()


func _on_quit_focus_exited() -> void:
	$VBoxContainer/HBoxContainer3/SubViewportContainer.hide()
