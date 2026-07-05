extends Control

func ready():
	for button in $NinePatchRect/MarginContainer/HBoxContainer.get_children():
		button.get_child(0).hide()
	$NinePatchRect/MarginContainer/HBoxContainer.get_child(0).grab_focus

func _on_button_pressed() -> void:
	pass # Replace with function body.


func _on_button_focus_entered() -> void:
	pass # Replace with function body.


func _on_button_focus_exited() -> void:
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_button_2_focus_entered() -> void:
	pass # Replace with function body.


func _on_button_2_focus_exited() -> void:
	pass # Replace with function body.
