extends Node

@onready var clouds: Sprite2D = $"Parallaxes/2"


func _ready() -> void:
	$VBoxContainer/HBoxContainer/SubViewportContainer.show()
	$VBoxContainer/HBoxContainer/New.grab_focus()
	Music.music.stream = load("res://assets/OST/1.02 BEING SLOW ON THE WAVES.mp3")
	Music.music.play()
	
func _process(delta: float) -> void:
	clouds.position.x -= 0.5
	if clouds.position.x <= 0.0:
		clouds.position.x = 575

func _input(event: InputEvent) -> void:
	var select = Input.get_axis("ui_up","ui_down")
	if select:
		$Modern2.play()
		pass

func _on_new_pressed() -> void:
	Music.music.stop()
	$Modern8.play()
	TransitionLayer.change_scene(SaveLoad.save_file.current_room)


func _on_load_pressed() -> void:
	Music.music.stop()
	$Modern8.play()
	SaveLoad._load()
	TransitionLayer.change_scene(SaveLoad.save_file.current_room)


func _on_quit_pressed() -> void:
	$Modern14.play()
	await get_tree().create_timer(0.2).timeout
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
