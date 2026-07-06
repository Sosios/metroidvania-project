extends Control

var map_scene = preload("res://map/map.tscn")
@onready var canvas_layer: CanvasLayer = $CanvasLayer


func _ready():
	get_tree().paused = true
	Globals.dialogue = true
	for button in $NinePatchRect/MarginContainer/HBoxContainer.get_children():
		#print(">>> bouton: ", button.name, " focus_mode avant=", button.focus_mode)
		button.focus_mode = Control.FOCUS_ALL
		#print(">>> focus_mode après=", button.focus_mode)
	$NinePatchRect/MarginContainer/HBoxContainer/Button.grab_focus()

func _on_button_pressed() -> void:
	SaveLoad._save()
	Globals.health = SaveLoad.save_file.max_health
	queue_free()
	get_tree().paused = false


func _on_button_focus_entered() -> void:
	$NinePatchRect/MarginContainer/HBoxContainer/Button/Label.label_settings.font_color = Color("000000")


func _on_button_focus_exited() -> void:
	$NinePatchRect/MarginContainer/HBoxContainer/Button/Label.label_settings.font_color = Color("874f44")


func _on_button_2_pressed() -> void:
	var map = map_scene.instantiate()
	map.type = 1
	canvas_layer.add_child(map)
	for button in $NinePatchRect/MarginContainer/HBoxContainer.get_children():
		#print(">>> bouton: ", button.name, " focus_mode avant=", button.focus_mode)
		button.focus_mode = Control.FOCUS_NONE
	#await Globals.teleport
	#for button in $NinePatchRect/MarginContainer/HBoxContainer.get_children():
		#print(">>> bouton: ", button.name, " focus_mode avant=", button.focus_mode)
		#button.focus_mode = Control.FOCUS_ALL


func _on_button_2_focus_entered() -> void:
	$NinePatchRect/MarginContainer/HBoxContainer/Button2/Label.label_settings.font_color = Color("000000")


func _on_button_2_focus_exited() -> void:
	$NinePatchRect/MarginContainer/HBoxContainer/Button2/Label.label_settings.font_color = Color("874f44")
