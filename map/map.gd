extends Node2D


func _ready():
	$IndicationsDev.hide()
	
func resume():
	get_tree().paused = false
	hide()
	
func paused():
	get_tree().paused = true
	show()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("map"):
		if get_tree().paused:
			resume()
		else:
			paused()
			$MapRooms.update()
			$MapRooms.update_discover()
